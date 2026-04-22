<?php
include 'db.php';
session_start();

$topic_id = $_GET['topic_id'];
$query = $conn->prepare("SELECT * FROM questions WHERE topic_id = ?");
$query->bind_param("i", $topic_id);
$query->execute();
$result = $query->get_result();
$questions = [];

while($row = $result->fetch_assoc()) {
    $answers = [$row['correct_answer'], $row['wrong_1'], $row['wrong_2'], $row['wrong_3']];
    shuffle($answers);
    $row['shuffled_answers'] = $answers;
    $questions[] = $row;
}
shuffle($questions);
?>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
    <script>
        let questions = <?php echo json_encode($questions); ?>;
        let currentIdx = 0;
        let score = 0;
        let wrongQuestions = [];

        function showQuestion() {
            if (currentIdx >= questions.length) {
                let wrongJson = JSON.stringify(wrongQuestions);
                window.location.href = "result.php?score=" + score + "&total=" + questions.length + "&wrong=" + encodeURIComponent(wrongJson);
                return;
            }
            let q = questions[currentIdx];
            document.getElementById('q_text').innerText = q.question_text;
            let optionsHtml = '';
            q.shuffled_answers.forEach(ans => {
                optionsHtml += `<label class="option-label"><input type="radio" name="ans" value="${ans}"> ${ans}</label>`;
            });
            document.getElementById('options').innerHTML = optionsHtml;
            document.getElementById('progress').style.width = ((currentIdx / questions.length) * 100) + "%";
        }

        function nextQuestion() {
            let selected = document.querySelector('input[name="ans"]:checked');
            if (!selected) return alert("Izvēlies atbildi!");
            if (selected.value === questions[currentIdx].correct_answer) {
                score++;
            } else {
                wrongQuestions.push({
                    question: questions[currentIdx].question_text,
                    correct: questions[currentIdx].correct_answer,
                    selected: selected.value
                });
            }
            currentIdx++;
            showQuestion();
        }

        window.onload = showQuestion;
    </script>
</head>
<body>
<div class="container">
    <div class="progress-container"><div id="progress" class="progress-bar"></div></div>
    <h3 id="q_text"></h3>
    <div id="options"></div>
    <button onclick="nextQuestion()">Nākamais</button>
</div>
</body>
</html>