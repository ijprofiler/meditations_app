import 'package:flutter/material.dart';
import 'package:new_meditations/models/item_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MeditationAppScreen extends StatefulWidget {
  @override
  _MeditationAppScreen createState() => _MeditationAppScreen();
}

class _MeditationAppScreen extends State<MeditationAppScreen> {
  final List<Item> items = [
    Item(
        name: "Forest",
        audioPath: "meditaiton_audios/forest.mp3",
        imagePath: "meditation_images/forest.jpeg"),
    Item(
        name: "Night",
        audioPath: "meditaiton_audios/night.mp3",
        imagePath: "meditation_images/night.jpeg"),
    Item(
        name: "Ocean",
        audioPath: "meditaiton_audios/ocean.mp3",
        imagePath: "meditation_images/ocean.jpeg"),
    Item(
        name: "Waterfall",
        audioPath: "meditaiton_audios/waterfall.mp3",
        imagePath: "meditation_images/waterfall.jpeg"),
    Item(
        name: "Wind",
        audioPath: "meditaiton_audios/wind.mp3",
        imagePath: "meditation_images/wind.jpeg")
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  int? playingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(items[index].imagePath),
                      ),
                    ),
                    child: ListTile(
                      title: Text(items[index].name),
                      leading: IconButton(
                        icon: playingIndex == index
                            ? FaIcon(FontAwesomeIcons.stop)
                            : FaIcon(FontAwesomeIcons.play),
                        onPressed: () async {
                          if (playingIndex == index) {
                            setState(() {
                              playingIndex = null;
                            });

                            audioPlayer.stop();
                          } else {
                            try {
                              await audioPlayer
                                  .setAsset(items[index].audioPath)
                                  .catchError((onError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content:
                                        Text("Oops, an error has occured..."),
                                  ),
                                );
                              });
                              audioPlayer.play();

                              setState(() {
                                playingIndex = index;
                              });
                            } catch (error) {
                              print(error);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
