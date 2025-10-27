#  BootX

A lightweight x86 bootloader project built from scratch using **GCC**, **CMake**, and **QEMU**.  

---

## 🚀 Overview

**BootX** is a minimal bootloader designed to explore how low-level system initialization works on x86 architecture.  
It demonstrates key concepts like boot sector programming, kernel loading, and transitioning from **real mode** to **protected mode** — all built using open-source tools.

---

## ⚙️ Tools & Technologies Used

| Tool | Purpose |
|------|----------|
| **GCC (x86)** | Compiling C code and linking bootloader components |
| **CMake** | Build automation and project structure management |
| **QEMU** | Virtual machine emulator for testing bootable images |
| **Bless** | Hex editor used for inspecting and editing raw binary sectors |
| **Make / Shell** | Automating build and run steps |

---

## 🗂️ Project Structure
BootX/
├── src/ # Source files (bootloader, kernel, etc.)
├── build/ # Compiled binaries and intermediate files
├── CMakeLists.txt # CMake build configuration
├── Makefile # Optional make wrapper for convenience
├── run.sh # Script to launch the OS in QEMU
├── LICENSE
└── README.md

## 🧩 Features

- Custom **x86 bootloader** written in Assembly and C  
- Loads and jumps to a simple **kernel** or second-stage code  
- Demonstrates **real mode → protected mode** transition  
- Bootable **.bin / .img** created from scratch  
- Fully testable in **QEMU** — no real hardware required  
- Uses **CMake** for clean and reproducible builds  

---
