import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class SuggestionsPage extends StatefulWidget {
  final double score;

  SuggestionsPage({required this.score}); // استقبال النتيجة

  @override
  _SuggestionsPageState createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  late YoutubePlayerController _controller;
  List<String> _videoUrls = [];
  List<String> _recommendedVideos = [];
  int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadVideoLinks();
  }

  Future<void> _loadVideoLinks() async {
    final String response = await rootBundle.loadString('assets/suggestions_video_links.json');
    final data = json.decode(response);
    setState(() {
      _videoUrls = List<String>.from(data['videos']);
      _setRecommendedVideos();
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(_recommendedVideos[_currentVideoIndex])!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    });
  }

  void _setRecommendedVideos() {
    if (widget.score >= 70) {
      _recommendedVideos = _videoUrls.sublist(0, 3); // من 1 إلى 3 فيديوهات
    } else if (widget.score >= 40) {
      _recommendedVideos = _videoUrls.sublist(3, 6); // من 4 إلى 6 فيديوهات
    } else {
      _recommendedVideos = _videoUrls.sublist(6, 9); // من 7 إلى 9 فيديوهات
    }
  }

  void _loadVideo(int index) {
    setState(() {
      _currentVideoIndex = index;
      _controller.load(YoutubePlayer.convertUrlToId(_recommendedVideos[_currentVideoIndex])!);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        title: Text('Video Suggestions', style: TextStyle(fontSize: 24)),
      ),
      body: Column(
        children: [
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
          // عرض الفيديوهات المقترحة
          Expanded(
            child: ListView.builder(
              itemCount: _recommendedVideos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Video ${index + 1}'),
                  onTap: () {
                    _loadVideo(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
