function displayQuestion() {
    const q = questions[currentStep];
    document.getElementById("q_text").innerText = q.question;
    
    const optionsDiv = document.getElementById("options");
    optionsDiv.innerHTML = ""; // Notīrām vecās atbildes

    q.answers.forEach((ans, index) => {
        const label = document.createElement("label");
        label.className = "option-label"; // Šī rinda ir izšķiroša!
        
        label.innerHTML = `
            <input type="radio" name="quiz" value="${index}">
            <span>${ans}</span>
        `;
        
        optionsDiv.appendChild(label);
    });
}

// Funkcija, kas saglabā rezultātu
function saveResult(topic, score, total) {
    // 1. Iegūstam esošo vēsturi no localStorage vai izveidojam tukšu masīvu
    let history = JSON.parse(localStorage.getItem("quizHistory")) || [];

    // 2. Izveidojam jaunu ierakstu
    const newEntry = {
        topic: topic,
        score: score,
        total: total,
        date: new Date().toLocaleDateString('lv-LV')
    };

    // 3. Pievienojam saraksta sākumā un saglabājam atpakaļ
    history.unshift(newEntry);
    localStorage.setItem("quizHistory", JSON.stringify(history));
}

// Funkcija, kas parāda vēsturi ekrānā
function showHistory() {
    document.getElementById("setup-screen").style.display = "none";
    document.getElementById("quiz-screen").style.display = "none";
    document.getElementById("history-screen").style.display = "block";

    const list = document.getElementById("history-list");
    const history = JSON.parse(localStorage.getItem("quizHistory")) || [];

    if (history.length === 0) {
        list.innerHTML = "<p style='text-align:center;'>Vēsture ir tukša.</p>";
        return;
    }

    list.innerHTML = history.map(item => `
        <div class="history-item">
            <div class="history-info">
                <strong>${item.topic}</strong>
                <small>${item.date}</small>
            </div>
            <div class="history-score">${item.score} / ${item.total}</div>
        </div>
    `).join('');
}

function clearHistory() {
    if(confirm("Vai tiešām dzēst visu vēsturi?")) {
        localStorage.removeItem("quizHistory");
        showHistory();
    }
}