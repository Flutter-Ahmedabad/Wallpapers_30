import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpapers_30/walpaper_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpapers'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          var walpaperState =
              Provider.of<WalpaperState>(context, listen: false);
          walpaperState.fetchImages();
        },
      ),
      body: Consumer<WalpaperState>(
        builder: (context, walpaperState, child) {
          /// if busy = false && the response is null => no data
          /// if busy = true => show loading
          /// if busy = false and we have data then show it
          ///

          if (walpaperState.isBusy) {
            return Center(child: CircularProgressIndicator());
          } else if (!walpaperState.isBusy &&
              walpaperState.imagesResponse != null) {
            return ListView.builder(
              itemCount: walpaperState.imagesResponse.hits.length,
              itemBuilder: (context, index) {
                var item = walpaperState.imagesResponse.hits[index];
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                  child: Card(
                    child: GestureDetector(
                      onTap: () {
                        walpaperState.setwallpaper(item.largeImageUrl);
                      },
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              item.previewUrl,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black87,
                                  ],
                                )),
                                child: Text(
                                  item.tags,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.red,
                                        offset: Offset(1, 1),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No data loaded\nTry to refresh'),
            );
          }
        },
      ),
    );
  }
}
