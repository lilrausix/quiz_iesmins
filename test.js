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

let tempQuestions = []; // Šeit glabāsim jautājumus pirms tēmas saglabāšanas

function loginAdmin() {
    const user = document.getElementById("admin-user").value;
    const pass = document.getElementById("admin-pass").value;

    if (user === "Rukitis" && pass === "Admin321") {
        document.getElementById("admin-login").style.display = "none";
        document.getElementById("admin-panel").style.display = "block";
        loadTopics();
    } else {
        alert("Nepareizs lietotājvārds vai parole!");
    }
}

function addQuestionToTopic() {
    const qText = document.getElementById("q-text-input").value;
    const ansInputs = document.querySelectorAll(".ans-input");
    const answers = Array.from(ansInputs).map(i => i.value).filter(v => v !== "");

    if (qText && answers.length >= 2) {
        tempQuestions.push({
            question: qText,
            answers: answers,
            correct: 0 // Šajā piemērā pirmā atbilde vienmēr ir pareizā
        });
        
        // Notīrām laukus nākamajam jautājumam
        document.getElementById("q-text-input").value = "";
        ansInputs.forEach(i => i.value = "");
        document.getElementById("q-count").innerText = `Pievienoti jautājumi: ${tempQuestions.length}`;
    } else {
        alert("Aizpildi jautājumu un vismaz 2 atbildes!");
    }
}

function saveTopic() {
    const topicName = document.getElementById("new-topic").value;
    if (!topicName || tempQuestions.length === 0) {
        alert("Ievadi tēmas nosaukumu un pievieno jautājumus!");
        return;
    }

    // Send to server
    const formData = new FormData();
    formData.append('topic_title', topicName);
    formData.append('questions', JSON.stringify(tempQuestions));

    fetch('admin_save.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert("Tēma veiksmīgi saglabāta!");
            // Reset
            tempQuestions = [];
            document.getElementById("new-topic").value = "";
            document.getElementById("q-count").innerText = "Pievienoti jautājumi: 0";
            loadTopics(); // Reload topics list
        } else {
            alert("Kļūda: " + data.message);
        }
    })
    .catch(error => {
        alert("Kļūda saglabājot: " + error);
    });
}

function logoutAdmin() {
    document.getElementById("admin-panel").style.display = "none";
    document.getElementById("setup-screen").style.display = "block";
}

function loadTopics() {
    fetch('get_topics.php')
    .then(response => response.json())
    .then(topics => {
        const list = document.getElementById('topics-list');
        list.innerHTML = topics.map(topic => `
            <div style="margin: 10px 0; padding: 10px; border: 1px solid #ccc;">
                <strong>${topic.title}</strong>
                <button onclick="deleteTopic(${topic.id})" style="background: #dc3545; color: white; margin-left: 10px;">Dzēst</button>
            </div>
        `).join('');
    })
    .catch(error => console.error('Error loading topics:', error));
}

function deleteTopic(topicId) {
    if (!confirm('Vai tiešām dzēst šo tēmu?')) return;

    const formData = new FormData();
    formData.append('topic_id', topicId);

    fetch('delete_topic.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Tēma dzēsta!');
            loadTopics(); // Reload the list
        } else {
            alert('Kļūda: ' + data.message);
        }
    })
    .catch(error => alert('Kļūda dzēšot: ' + error));
}