# Bash Project Manager

### update - **This was one of my first projects. no real world use anymore**

A lightweight, terminal-based C/C++ project manager built in pure Bash.  
It lets you **edit**, **build**, **debug**, **run**, **delete**, and **list** projects quickly from one menu — no IDE required.

## 📦 Features

- Edit source files directly in Nano  
- Compile C and C++ projects using Clang or Clang++  
- Debug builds with `-g` flags  
- Automatically manages `src`, `compiled`, and `tmp` directories  
- Simple text-based menu for all actions  
- Basic error handling and colored terminal output  

## ⚙️ Requirements

- **Bash** (v4 or higher)
- **Clang / Clang++** installed in `PATH`
- **Nano** and **Touch** also available in `PATH`

## 📂 Directory Structure

- **`src/`** — Editable source files  
- **`compiled/`** — Compiled project binaries  
- **`tmp/`** — Temporary files created during build/debug  
- **`run.sh`** — Main script
- **`install.sh`** - Installation script

*All directories are created by the install.sh if they do not exist.*
