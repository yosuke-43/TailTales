document.addEventListener("turbo:load", function() {
  console.log("JavaScript file loaded!!!");
  var startContent = document.getElementById("start_content");
  var startLinkContainer = document.getElementById("start_link_container");
  var diagnosticsContainer = document.getElementById("diagnostics_container");

  startLinkContainer.addEventListener('click', function(event) {
    event.preventDefault();
    startContent.style.display = 'none';
    startLinkContainer.style.display = 'none';
    diagnosticsContainer.style.display = 'block';
  });
  
  var questions = document.querySelectorAll('.question_box');
  var backButton = document.getElementById("question_return");
  var submitButton = document.getElementById("question_submit");
  submitButton.style.display = 'none';
  var currentQuestionIndex = 0;

  questions.forEach(function(question, index) {
    if (index > 0) {
      question.style.display = 'none';
    }
  });

  backButton.style.display = 'none';

  document.querySelectorAll('input[type="radio"]').forEach(function(radio) {
    radio.addEventListener('click', function() {
      var currentQuestion = questions[currentQuestionIndex];
      var nextQuestion = questions[currentQuestionIndex + 1];

      if (nextQuestion) {
        currentQuestion.style.display = 'none';
        nextQuestion.style.display = 'block';
        currentQuestionIndex++;

        // 質問が最初のものでなければ「前へ」ボタンを表示
        backButton.style.display = (currentQuestionIndex > 0) ? 'block' : 'none';
      } else {
        submitButton.style.display = 'block'
      };
    });
  });

  backButton.addEventListener('click', function(event) {
    event.preventDefault();
    var currentQuestion = questions[currentQuestionIndex];
    var previousQuestion = questions[currentQuestionIndex - 1];

    if (previousQuestion) {
      currentQuestion.style.display = 'none';
      previousQuestion.style.display = 'block';
      currentQuestionIndex--;
    }

    // 質問が最初のものでなければ「前へ」ボタンを表示
    backButton.style.display = (currentQuestionIndex > 0) ? 'block' : 'none';
  });
});