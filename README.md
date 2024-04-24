# Morse Translator
## What is it?
This app has two functions, it is a generic (modern) morse code translator, but there is also a "classic" translator that detects the duration of your presses and the time between these presses. Because of this, it is able to take input with only 1 button.

These are the timings that belong with the button:
- Press for 0ms - 200ms: dot
- Press for 200ms or more: stripe
- Pause for 350ms - 1000ms: next letter
- Pause for 1000ms or more: next word

## Things to keep in mind
This app was made by someone who had no prior knowledge of Flutter 2 months ago. I did this project to develop my Flutter skills (and it worked out). The code could probably be written in a more efficient way.