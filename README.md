# AI Quest Habit Tracker

## How it started
This habit tracker has been a passion project of mine for the last few months. Its a Medeival Fantasy themed habit tracker that I made to help  gamify my habits and systems building. It actually started off as a simple pen-and-paper D&D style character sheet that I managed manually. Then it moved into my Obsidian notebook with some fancy task queries for easier quest management, and then when I got annoyed with manually asking ChatGPT to generate a quest for me and updating my character sheet, and a light bulb popped up and I said "hey this is a perfect use-case for an app!"

## How it works
**Characters** in this world represent a Habit. They have a motivation and backstory that is guided by your habit. 
Characters can venture out on **Quests** which earn them experiance and loot, which you can then use in town at the **Marketplace** and buy some Rewards for your hard work and efforts in keeping

## How it was made
Why I chose Swift and iOS is beyond me. I hardly ever programmed in Swift. In retrospet it would have been much easier to use a stack I was more familiar with, but I learned a good amount of Swift. The architecture is fairly straightforeward and based very heavily on the Apple Developer Tutorials.

SwiftUI - modern declarative framework for writing iOS app
SwiftData - Local SQLite DB that runs on-device
Google Gemini - LLM used to generate JSON for Characters and Quests
Ollama(optional) - if your computer can run a local LLM like Llama 3.2 (confirmed with M1 Mac) you can use Ollama for various queries with reasonable success

The assets and images were all generated using Gemini. 

## Usage 
BYOK (Bring Your Own Key):
1. generate a Gemini API key through [Google AI Studio](https://aistudio.google.com/apikey)
2. In the `AIQuest` directory create a new configuration file called `Config.xcconfig`
3. Add `GEMINI_API_KEY=<YOUR API KEY HERE>` to the Config
