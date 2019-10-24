from PIL import Image, ImageDraw
from math import sqrt, pi, cos, sin
from canny import canny_edge_detector
from collections import defaultdict
import argparse
import sys



# Load image:
input_image = Image.open(sys.argv[1])

# Output image:
output_image = Image.new("RGB", input_image.size)
output_image.paste(input_image)
draw_result = ImageDraw.Draw(output_image)

# Find circles
rmin = 12
rmax = 15
steps = 100
threshold = 0.6

points = []
for r in range(rmin, rmax + 1):
    for t in range(steps):
        points.append((r, int(r * cos(2 * pi * t / steps)), int(r * sin(2 * pi * t / steps))))

print("Step 1 Completed")

acc = defaultdict(int)
for x, y in canny_edge_detector(input_image):
    for r, dx, dy in points:
        a = x - dx
        b = y - dy
        acc[(a, b, r)] += 1

print("Step 2 Completed")

circles = []
for k, v in acc.items(): #sorted(acc.items(), key=lambda i: -i[1]):
    x, y, r = k
    if v / steps >= threshold and all((x - xc) ** 2 + (y - yc) ** 2 > rc ** 2 for xc, yc, rc in circles):
        #print(v / steps, x, y, r)
        circles.append((x, y, r))

print("Step 3 Completed")

for x, y, r in circles:
    draw_result.ellipse((x-r, y-r, x+r, y+r), outline=(255,0,0,0))

print("Step 4 Completed")

circles = sorted(circles , key=lambda k: [k[0], k[1], k[2]])
questions = []
current_question = []
current_question.append(circles[0])

for i in range(1, len(circles)-1):
	if abs(circles[i][1]-circles[i-1][1]) < 5:
		current_question.append(circles[i])
	else:
		questions.append(current_question)
		current_question = []

#for i in range(0,len(questions)-1):
#	if len(questions[i]) > 5:
#		questions.pop(i)
count=0
for i in questions:
	print(count, len(i))
	count+=1
count = 0
for i in questions:
	print(count,i)
	count+=1

print(len(questions))
# Save output image
output_image.save("result.png")
