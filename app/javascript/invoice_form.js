
  document.addEventListener("DOMContentLoaded", function() {
    const selectCapture = document.getElementById('select-capture');
    const selectUpload = document.getElementById('select-upload');
    const captureSection = document.getElementById('capture-section');
    const uploadSection = document.getElementById('upload-section');
    const video = document.getElementById('webcam');
    const canvas = document.getElementById('canvas');
    const captureButton = document.getElementById('capture');
    const capturedImageField = document.getElementById('captured_image');
    const fileUpload = document.getElementById('file_upload');
    const preview = document.getElementById('preview');
    const previewImg = document.getElementById('preview-img');
    let stream = null;

    // Hide both sections initially
    captureSection.style.display = 'none';
    uploadSection.style.display = 'none';

    // Show webcam capture section
    selectCapture.addEventListener('click', () => {
      captureSection.style.display = 'block';
      uploadSection.style.display = 'none';

      navigator.mediaDevices.getUserMedia({ video: true })
        .then(mediaStream => {
          stream = mediaStream;
          video.srcObject = stream;
        })
        .catch(err => {
          console.error("Error accessing webcam: ", err);
          alert("Could not access webcam. Please use file upload instead.");
        });
    });

    // Show file upload section
    selectUpload.addEventListener('click', () => {
      uploadSection.style.display = 'block';
      captureSection.style.display = 'none';

      if (stream) {
        stream.getTracks().forEach(track => track.stop());
        video.srcObject = null;
      }
    });

    // Capture image from webcam
    captureButton.addEventListener('click', () => {
      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;
      canvas.getContext('2d').drawImage(video, 0, 0);
      const imageData = canvas.toDataURL('image/png');
      capturedImageField.value = imageData;
      previewImg.src = imageData;
      previewImg.style.display = 'block';

      if (stream) {
        stream.getTracks().forEach(track => track.stop());
        video.srcObject = null;
      }
    });
  });
