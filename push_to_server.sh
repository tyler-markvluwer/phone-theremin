rm -r theremin
broccoli build theremin
scp -r theremin tylermar@login.engin.umich.edu:/home/tylermar/Public/html
rm -r theremin