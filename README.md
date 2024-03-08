CodeCard is a project aimed at displaying a collection of Magic: The Gathering (MTG) cards fetched from an API or stored locally in JSON format. It allows users to view cards categorized by different types such as Artifact, Creature, Instant, Sorcery, etc., and provides a seamless browsing experience.

#Key Features:

1.Fetches card data from a mock API or locally stored JSON file.
2.Displays cards in a UICollectionView with filtering options based on card types.
3.Utilizes asynchronous programming for efficient data fetching and loading.
4.Supports dynamic updating of segmented control titles based on fetched card types.
5.Implements error handling to manage API fetch failures or JSON parsing errors.
6.Enhances code readability, maintainability, and productivity through well-organized code structure and comments.

#Technologies Used:

1.Swift
2.UIKit
3.JSON Serialization
4.Asynchronous Programming
5.Model-View-Controller (MVC) Architecture

How to Use:

1.Clone or download the project repository.
2.Open the project in Xcode.
3.Build and run the project on a simulator or physical device.
4.xplore the collection of MTG cards by navigating through the segmented control options.
5.Enjoy browsing the cards with dynamically updated content fetched from the API or stored in the local JSON file.
Note:

This project includes a mock API function (APIImpl.shared.getCards()) for fetching card data. Alternatively, you can load card data directly from the bundled JSON file (mtg_card_subset.json).
The data displayed in this project is for demonstration purposes and may not represent the full collection of MTG cards.
Credits:

The data used in this project is exported from MTGJSON (https://mtgjson.com/license/).

Feel free to adjust the description as needed to accurately represent your project and its features.
