# StegnographyR
Recently, I was reading about Steganography[1] and I thought about creating my own tool that can hide data in form of text inside images without causing much damage to the quality of image. I chose R for creating this entire project because of the large number of Image Processing packages available in R. Moreover, the documentation available for R and it’s packages is very neat which substantially reduces the development time.

With the platform and idea, I developed this software that hides the textual data into images by encoding them into intensity values of the pixels in the images.
Here are some screenshots of the app:-

Consider this image that we will use for hiding our data in.

![](https://qph.cf2.quoracdn.net/main-qimg-751b9a8065b0fb0c5942dff4aae31e3c-pjlq)


Then, we execute the application step by step:-

It asks us to select an input image.
![](https://qph.cf2.quoracdn.net/main-qimg-872b957ff87c1fb0862a56a5b6af8694-pjlq)
![](https://qph.cf2.quoracdn.net/main-qimg-e5ea879ab14a727e4399dfe4012642a7-pjlq)


2.Then the system asks for the message you want to hide inside the image.

![](https://qph.cf2.quoracdn.net/main-qimg-2638d72d371a502ff4321b1df7afd96c-pjlq)


Note : The maximum limit on number of characters is dependent upon the resolution of the input image.

3. It performs certain operations on image and produce an output image. It shows a successful message once the process is over. It also shows the percentage loss at pixel level in quality of image. The user specifies the save location for output image and the system writes the image file onto that location.

![](https://qph.cf2.quoracdn.net/main-qimg-81f46c4d44e6f83e89a8ed0e3a4b058e)
![](https://qph.cf2.quoracdn.net/main-qimg-0d6a5508efe69aa6bcf1cb12cece689c-pjlq)

After saving the image, we can see that there is not much difference visible in the new image.

![](https://qph.cf2.quoracdn.net/main-qimg-d01a990f19529fdd58318bd01b0d287c-pjlq)

Note : This image now stores some textual information as well. The quality seems pretty much the same due to low information loss which happened because of short message. Quality of image will decrease for longer texts but the difference will not be clearly visible to eyes.

Obtaining the data back from the image is the exact reverse of the above-mentioned process.

1.Select the image you wish to decode.
![](https://qph.cf2.quoracdn.net/main-qimg-398c4f627638756a4432fb1c64f2eec3)
![](https://qph.cf2.quoracdn.net/main-qimg-57b32a3763321c6f1874813399d26e80-pjlq)

2.Based on the technique used for hiding the data in image, we extract it out from the image.

![](https://qph.cf2.quoracdn.net/main-qimg-e31c384f3a0bd4133029f5848f6cda7c-pjlq)

We obtain the same message back.

Steganography has an advantage over cryptography in terms of security which is that it doesn’t attract attention of malicious attackers.

This entire application was developed in RStudio using R.
