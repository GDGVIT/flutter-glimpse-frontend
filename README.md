<p align="center">
<a href="https://dscvit.com">
	<img width="400" src="https://user-images.githubusercontent.com/56252312/159312411-58410727-3933-4224-b43e-4e9b627838a3.png#gh-light-mode-only" alt="GDSC VIT"/>
</a>
	<h2 align="center">Flutter SDUI Designer</h2>
	<h4 align="center">A Figma-like Flutter UI designer with drag and drop functionality for creating Flutter applications visually<h4>
</p>

---
[![Join Us](https://img.shields.io/badge/Join%20Us-Developer%20Student%20Clubs-red)](https://dsc.community.dev/vellore-institute-of-technology/)
[![Discord Chat](https://img.shields.io/discord/760928671698649098.svg)](https://discord.gg/498KVdSKWR)

[![DOCS](https://img.shields.io/badge/Documentation-see%20docs-green?style=flat-square&logo=appveyor)](INSERT_LINK_FOR_DOCS_HERE) 
[![UI](https://img.shields.io/badge/User%20Interface-Link%20to%20UI-orange?style=flat-square&logo=appveyor)](INSERT_UI_LINK_HERE)

## Overview

Flutter SDUI Designer is a powerful visual design tool that brings the familiar drag-and-drop interface of design tools like Figma to Flutter development. Built with modern Flutter best practices and MVVM architecture, it enables developers and designers to create Flutter UIs visually while automatically generating clean, production-ready code.

## Features

### Core Functionality
- [x] **Drag and Drop Interface**: Intuitive drag-and-drop system for adding widgets from the sidebar directly onto the design canvas
- [x] **Visual Widget Library**: Comprehensive collection of pre-built widgets including Row, Column, Scaffold, Text, Container, Card, and more
- [x] **Properties Panel**: Real-time property editing with advanced controls including color pickers, size adjustments, and styling options
- [x] **Modern UI**: Clean, professional interface inspired by Figma with Material Design 3 components
- [x] **MVVM Architecture**: Built following Flutter best practices for maintainable and scalable code

### Advanced Features
- [x] **Device Preview**: Preview your designs across different device sizes, screen resolutions, and orientations to ensure responsive layouts
- [x] **Widget Tree Visualization**: Interactive hierarchical view of your widget structure for easy navigation and management
- [x] **Import/Export Functionality**: Save and load design files, export generated Flutter code for immediate use in your projects
- [x] **Theme Management**: Comprehensive theming system with customizable color schemes, typography, and Material Design theme configurations
- [x] **Code Generation**: Automatically generate clean, optimized Flutter code from your visual designs

## Available Widgets

- **Row**: Horizontal layout widget with configurable alignment and spacing
- **Column**: Vertical layout widget with flexible positioning options
- **Scaffold**: Basic Material app structure with app bar and body support
- **Text**: Text display widget with customizable font, size, color, and weight
- **Container**: Flexible container with padding, margin, border, and background styling
- **Card**: Material Design card widget with elevation and rounded corners

## Project Structure

```
lib/
├── main.dart              # App entry point
├── app.dart               # Main app configuration
├── screens/
│   └── designer_screen.dart  # Main designer screen
└── widgets/
    ├── left_sidebar.dart     # Left sidebar with widget library
    ├── design_canvas.dart    # Main design canvas
    └── properties_panel.dart # Properties editing panel
```

## Dependencies

- **flutter_riverpod**: State management solution
- **go_router**: Navigation routing (for future features)
- **cupertino_icons**: iOS-style icon library
- **flutter_glimpse**: Core dependency for the Flutter SDUI Designer

## Getting Started

### Prerequisites
- Flutter SDK installed on your system
- A code editor (VS Code, Android Studio, or IntelliJ IDEA recommended)

### Installation

1. Clone this repository:
```bash
git clone <repository-url>
cd flutter-sdui-designer
```

2. Install dependencies:
```bash
flutter pub get
# Or add the package directly
pub add flutter_glimpse
```

3. Run the application:
```bash
flutter run -d linux
# For other platforms: flutter run -d chrome, flutter run -d macos, etc.
```

## Usage

### Basic Workflow

1. **Adding Widgets**: Browse the widget library in the left sidebar and drag your desired widgets onto the canvas
2. **Selecting Widgets**: Click on any widget on the canvas to select it and view its properties
3. **Editing Properties**: Use the properties panel on the right side to modify widget attributes like colors, sizes, text content, and styling
4. **Device Preview**: Switch between different device previews to test your design's responsiveness
5. **Widget Tree**: Use the widget tree view to navigate complex layouts and manage parent-child relationships
6. **Export Code**: Generate and export Flutter code when your design is complete
7. **Clearing Canvas**: Use the clear button in the canvas toolbar to reset and start fresh

## Development

This project follows MVVM (Model-View-ViewModel) architecture patterns and Flutter best practices:
- Separation of concerns between UI and business logic
- Reactive state management with Riverpod
- Modular widget structure for reusability
- Clean code principles for maintainability

## Future Enhancements

- **Undo/Redo Functionality**: Full history management for design changes
- **Collaboration Features**: Real-time collaborative editing with multiple users
- **Extended Widget Library**: Support for more Flutter widgets and custom components
- **Animation Builder**: Visual tool for creating Flutter animations
- **Asset Management**: Image and icon asset integration
- **Responsive Breakpoints**: Advanced responsive design tools with breakpoint management
- **Plugin System**: Extensible architecture for community-built plugins

## Contributors

<table>
	<tr align="center">
    <td>
		Rujin Devkota
		<p align="center">
			<img src = "https://avatars.githubusercontent.com/u/71916379?v=4" width="150" height="150" alt="Rujin Devkota">
		</p>
			<p align="center">
				<a href = "https://github.com/rujin2003">
					<img src = "http://www.iconninja.com/files/241/825/211/round-collaboration-social-github-code-circle-network-icon.svg" width="36" height = "36" alt="GitHub"/>
				</a>
				<a href = "https://www.linkedin.com/in/rujin-devkota/">
					<img src = "http://www.iconninja.com/files/863/607/751/network-linkedin-social-connection-circular-circle-media-icon.svg" width="36" height="36" alt="LinkedIn"/>
				</a>
			</p>
		</td>
    <td>
		Adhavan K
		<p align="center">
			<img src = "https://avatars.githubusercontent.com/u/108629544?v=4" width="150" height="150" alt="Adhavan K">
		</p>
			<p align="center">
				<a href = "https://github.com/TBA5854">
					<img src = "http://www.iconninja.com/files/241/825/211/round-collaboration-social-github-code-circle-network-icon.svg" width="36" height = "36" alt="GitHub"/>
				</a>
				<a href = "https://www.linkedin.com/in/adhavan-k-503b8a28a/">
					<img src = "http://www.iconninja.com/files/863/607/751/network-linkedin-social-connection-circular-circle-media-icon.svg" width="36" height="36" alt="LinkedIn"/>
				</a>
			</p>
		</td>
	</tr>
</table>

<p align="center">
	Made with ❤ by <a href="https://dscvit.com">GDSC-VIT</a>
</p>
