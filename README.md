Chess iOS — Learning Project (SpriteKit + SwiftUI)

This project is an experimental clone of the chess.com iOS app, created for the purpose of learning SpriteKit, improving UIKit/SwiftUI integration skills, and exploring modern iOS app architecture.
It combines game logic written in SpriteKit with SwiftUI layouts, creating a flexible environment for experimenting with UI/UX and game mechanics.

🎯 Purpose of the Project

The goals of this project were:

To learn SpriteKit by building a full chess board from scratch

To understand how SwiftUI and SpriteKit can be combined in a single application

To practice interactive animations, gesture handling, and game state management

To replicate professional app UI patterns found in the chess.com mobile app

To prepare a foundation for building an original, feature-rich chess app in the future

🛠 Technologies Used

SpriteKit — for board rendering, move logic, piece interactions

SwiftUI — for menus, navigation, bottom tab bar, and modern UI elements

UIKit bridging using UIViewControllerRepresentable

Custom MV-style structure separating view, board, and logic layers

Asset-based rendering for clean piece and tile visuals

📱 Current Features

Fully rendered 8×8 chess board using SpriteKit

Tile-based movement system

Basic piece movement logic

SwiftUI interface with custom tab bar

Game scene embedded inside SwiftUI views

Smooth transition between pages

Early-stage chess.com-style UI replication

🔜 Next Steps (Roadmap)

This project will not remain a copy — the next phase is turning it into an original app with its own identity.

Planned improvements:

🎨 Design & UI

Redesign the interface to have a unique visual style

Improve animations, highlights, and move indicators

Add custom skins or themes for the board and pieces

♟ Gameplay Features

Implement proper move validation

Add game history, move list, and "undo move"

Add check, checkmate, and stalemate detection

Add a puzzle mode or mini-games

🌐 Online / Fun Features (experimental)

Local multiplayer

Online matchmaking (future)

Puzzle streaks, daily challenge

Training bots

Stats, profiles, streaks

🧱 Project Structure (Simplified)
Chess/
│
├── GameScene.swift        # SpriteKit board rendering
├── BoardNode.swift        # Tile grid, piece nodes, move logic
├── PiecesLogic/           # Piece movement rules
│
├── SwiftUI Views/
│   ├── ChessBoardScreen.swift
│   ├── CustomTabBar.swift
│   └── PlayButton.swift
│
└── Assets.xcassets        # Tile colors, piece images, icons

🚀 How to Run

Clone this repository:

git clone https://github.com/<your-username>/<repo-name>.git


Open the project in Xcode 15+

Run on any iOS 16+ device or simulator

📄 License

This is a learning project, not intended for commercial use.
The project currently replicates parts of the chess.com UI for educational purposes only.
