import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const PictureStoryApp());
}

class PictureStoryApp extends StatelessWidget {
  const PictureStoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picture Story Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StoryLibraryScreen(),
    );
  }
}

class StoryLibraryScreen extends StatelessWidget {
  const StoryLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add New Story'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Title'),
                  Text('Image'),
                  Text('Content'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Library'),
      ),
      body: ListView.builder(
        itemCount: storyList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the story viewer screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StoryViewerScreen(story: storyList[index]),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    storyList[index].coverImage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    storyList[index].title,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _showMyDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ignore: must_be_immutable
class StoryViewerScreen extends StatefulWidget {
  StoryViewerScreen({super.key, required this.story});
  final Story story;

  FlutterTts flutterTts = FlutterTts();

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreen();
}

class _StoryViewerScreen extends State<StoryViewerScreen> {
  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.story.coverImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.story.content,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Implement interactive elements or read-aloud functionality
                if (playing) {
                  await widget.flutterTts.pause();
                } else {
                  await widget.flutterTts.speak(widget.story.content);
                }
                setState(() {
                  playing = !playing;
                });
              },
              child: Text(playing ? 'Pause' : 'Read Aloud'),
            ),
          ],
        ),
      ),
    );
  }
}

class Story {
  final String title;
  final String coverImage;
  final String content;

  Story({required this.title, required this.coverImage, required this.content});
}

// Dummy data
List<Story> storyList = [
  Story(
    title: 'Bangladesh',
    coverImage: 'assets/1.jpeg',
    content:
        "Bangladesh, situated in South Asia, shares borders with India and Myanmar. "
        "Dhaka, the capital and largest city, is a vibrant hub of culture and commerce. "
        "With over 160 million people, it's densely populated. "
        "Bengali is the official language, reflecting the nation's rich linguistic heritage. "
        "The country emerged from a war of independence in 1971. "
        "Known for textiles and garments, Bangladesh's economy is a blend of agriculture, manufacturing, and services. "
        "Despite its natural beauty and historical sites, challenges like poverty and environmental issues persist. "
        "The Sundarbans mangrove forest shelters the iconic Royal Bengal tiger. Floods and cyclones are recurring threats due to the landscape. "
        "Bengali cuisine features rice, fish, and spices, embodying its cultural essence. "
        "Bangladesh's progress hinges on addressing socio-economic concerns and fostering stability. ",
  ),
  Story(
    title: 'Water Lily',
    coverImage: 'assets/3.jpeg',
    content:
      "The water lily, known as Shapla in Bengali, is an iconic aquatic plant in Bangladesh "
      "Adorning many water bodies, it symbolizes beauty and resilience. "
      "With its large, vibrant petals and floating leaves, it graces ponds and rivers across the country. "
      "The white water lily is the national flower of Bangladesh, representing purity and unity. "
      "Its presence in rural landscapes adds to the nation's natural charm. "
      "Often featured in local art and literature, the water lily holds cultural significance. "
      "Its growth is intertwined with the annual monsoon rains, flourishing during the wet season. "
      "Bangladesh's water lilies create serene and picturesque scenes amidst its lush environment. ",
  ),
  Story(
    title: 'Tiger',
    coverImage: 'assets/2.webp',
    content:
   "The Royal Bengal tiger, a majestic predator, is a symbol of strength and beauty in Bangladesh. "
   "Inhabiting the Sundarbans mangrove forest, it's one of the world's most iconic tiger species. "
   "Adapted to its unique habitat, the tiger is an apex predator in the delicate ecosystem. "
   "With distinctive stripes and powerful presence, it captures the imagination of both locals and visitors. "
   "Conservation efforts strive to protect this endangered species and its habitat. "
   "The tiger's survival is vital for maintaining the ecological balance of the Sundarbans. "
   "Despite its elusive nature, glimpses of this magnificent creature are cherished. "
   "Bangladesh's commitment to tiger preservation contributes to global biodiversity efforts. ",
  ),
  // Add more stories here
];
