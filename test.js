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