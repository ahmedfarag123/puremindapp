import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class EducationalContentPage extends StatefulWidget {
  @override
  _EducationalContentPageState createState() => _EducationalContentPageState();
}

class _EducationalContentPageState extends State<EducationalContentPage> {
  late YoutubePlayerController _controller;
  List<String> _videoUrls = [];
  int _currentVideoIndex = 0;
  bool _isMuted = false;
  bool _isPlaying = false;
  double _currentSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _loadVideoLinks();
  }

  Future<void> _loadVideoLinks() async {
    final String response = await rootBundle.loadString('assets/video_links.json');
    final data = json.decode(response);
    setState(() {
      _videoUrls = List<String>.from(data['videos']);
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(_videoUrls[_currentVideoIndex])!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    });
  }

  void _loadVideo(int index) {
    setState(() {
      _currentVideoIndex = index;
      _controller.load(YoutubePlayer.convertUrlToId(_videoUrls[index])!);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _play() {
    setState(() {
      _controller.play();
      _isPlaying = true;
    });
  }

  void _pause() {
    setState(() {
      _controller.pause();
      _isPlaying = false;
    });
  }

  void _changePlaybackSpeed(double speed) {
    setState(() {
      _currentSpeed = speed;
    });
    _controller.setPlaybackRate(speed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Video ${_currentVideoIndex + 1}', style: TextStyle(fontSize: 24)),
      ),
      body: Column(
        children: [
          // Container for the YouTube video section
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
            ),
          ),
          // Video controls (play, pause, seek, speed)
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                onPressed: () {
                  setState(() {
                    _isMuted = !_isMuted;
                    _controller.setVolume(_isMuted ? 0 : 100);
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: _play,
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: _pause,
              ),
              IconButton(
                icon: Icon(Icons.fast_rewind),
                onPressed: () {
                  final currentPosition = _controller.value.position;
                  _controller.seekTo(currentPosition - Duration(seconds: 10));
                },
              ),
              IconButton(
                icon: Icon(Icons.fast_forward),
                onPressed: () {
                  final currentPosition = _controller.value.position;
                  _controller.seekTo(currentPosition + Duration(seconds: 10));
                },
              ),
              Row(
                children: [
                  Icon(Icons.speed),
                  DropdownButton<double>(
                    value: _currentSpeed,
                    items: [
                      DropdownMenuItem(value: 0.5, child: Text('0.5x')),
                      DropdownMenuItem(value: 1.0, child: Text('1.0x')),
                      DropdownMenuItem(value: 1.5, child: Text('1.5x')),
                      DropdownMenuItem(value: 2.0, child: Text('2.0x')),
                    ],
                    onChanged: (speed) {
                      _changePlaybackSpeed(speed!);
                    },
                  ),
                ],
              ),
            ],
          ),
          // Video list
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: ListView.builder(
                itemCount: _videoUrls.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Video ${index + 1}'),
                    selected: index == _currentVideoIndex,
                    onTap: () {
                      _loadVideo(index);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
