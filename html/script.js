let attemptsLeft = 0;
let slots = [];
let maxAttempts = 0;

document.addEventListener('DOMContentLoaded', function() {
    const container = document.getElementById('game-container');
    if (container) {
        container.style.display = 'none';
    }
});

window.addEventListener('message', function(event) {
    const data = event.data;
    
    if (data.action === 'open') {
        // Inicializácia minihry
        slots = data.slots;
        maxAttempts = data.maxAttempts;
        attemptsLeft = maxAttempts;
        
        // Nastav počet pokusov
        document.getElementById('attempts-count').textContent = attemptsLeft;
        
        // Vytvor mriežku
        const grid = document.getElementById('grid');
        grid.innerHTML = '';
        grid.style.gridTemplateRows = `repeat(${data.rows}, 60px)`;
        grid.style.gridTemplateColumns = `repeat(${data.cols}, 60px)`;
        
        for (let i = 1; i <= slots.length; i++) {
            if (!slots[i]) continue; // Preskoč prázdne sloty
            const slot = document.createElement('div');
            slot.classList.add('slot');
            slot.dataset.index = i;
            slot.addEventListener('click', handleSlotClick);
            grid.appendChild(slot);
        }
        
        // Zobraz UI
        document.getElementById('game-container').style.display = 'flex';
    } else if (data.action === 'close') {
        document.getElementById('game-container').style.display = 'none';
    }
});

function handleSlotClick(e) {
    const slot = e.target;
    const index = parseInt(slot.dataset.index);
    
    if (slot.classList.contains('revealed')) return; // Slot už bol odokrytý
    
    attemptsLeft--;
    document.getElementById('attempts-count').textContent = attemptsLeft;
    
    slot.classList.add('revealed');
    slot.classList.add(slots[index]);
    
    if (slots[index] === 'item') {
        slot.textContent = '🎁'; // Ikona itemu
    } else if (slots[index] === 'cut') {
        slot.textContent = '🩸'; // Ikona porezania
    } else {
        slot.textContent = '∅'; // Prázdny slot
    }
    
    // Odošli výsledok na server
    fetch(`https://snt-trash/clickSlot`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ slotType: slots[index] })
    });
    
    // Ak už nie sú pokusy alebo našiel item, ukonči minihru
    if (attemptsLeft <= 0 || slots[index] === 'item') {
        setTimeout(() => {
            fetch(`https://snt-trash/endGame`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            });
        }, 1000);
    }
}

document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        // Pri stlačení ESC ukonči minihru
        fetch(`https://snt-trash/endGame`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        });
    }
});