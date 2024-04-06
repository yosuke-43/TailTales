document.addEventListener('turbo:load', function() {
  const previewImage = document.getElementById('preview');
  const fileInput = document.getElementById('board_board_image');

  fileInput.addEventListener('change', function() {
    const file = fileInput.files[0];

    if (file) {
      const reader = new FileReader();

      reader.onload = function(e) {
        previewImage.src = e.target.result;
      };

      reader.readAsDataURL(file);
    }
  });
});
