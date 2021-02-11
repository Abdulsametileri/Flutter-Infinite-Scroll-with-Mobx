import 'package:flutter/material.dart';
import 'package:infinite_scroll/model/card_model.dart';

class CardItemView extends StatelessWidget {
  final CardModel card;

  const CardItemView({Key key, this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Column(
        children: [_buildImageItem, _buildDescriptionItem],
      ),
    );
  }

  ListTile get _buildDescriptionItem {
    return ListTile(
      title: Text(card.author),
      subtitle: Text('H=${card.height} / W=${card.width}'),
      trailing: IconButton(
        icon: Icon(Icons.file_download),
        onPressed: () {},
      ),
    );
  }

  SizedBox get _buildImageItem {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Image.network(
          card.downloadUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
