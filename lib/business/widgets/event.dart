import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/business/widgets/avatar.dart';
import 'package:date_format/date_format.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget {
  Event event;

  EventItem(this.event, {Key key}) : super(key: key);

  @override
  _EventItemState createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: context.watch<BaseModel>().themeData.primaryColor,
              width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GitterAvatar(widget.event?.actor?.avatarUrl ?? '', width: 36.0),
              Padding(padding: EdgeInsets.symmetric(horizontal: 12.0)),
              Text(
                widget.event?.actor?.login ?? '',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
          EventText('Event ID: ' + widget.event?.id ?? ''),
          EventText('Event Name: ' + widget.event?.type ?? ''),
          EventText('Submit Time: ' +
                  (widget.event.createdAt != null
                      ? formatDate(widget.event?.createdAt,
                          [yyyy, '-', mm, '-', dd, ' - ', hh, ':', nn, ':', ss])
                      : '') ??
              ''),
          EventText('Submit Repository: ' + widget.event.repo?.name ?? ''),
          EventText('Payload Branch: ' +
                  (widget.event?.payload.containsKey('ref')
                      ? (widget.event?.payload['ref'] ?? '')
                      : '') ??
              ''),
          EventText('Payload Action: ' +
                  (widget.event?.payload.containsKey('action')
                      ? (widget.event?.payload['action'] ?? '')
                      : '') ??
              ''),
          EventText('Payload Head: ' +
                  (widget.event?.payload.containsKey('head')
                      ? (widget.event?.payload['head'] ?? '')
                      : '') ??
              ''),
          EventText('Payload Before: ' +
                  (widget.event?.payload.containsKey('before')
                      ? (widget.event?.payload['before'] ?? '')
                      : '') ??
              ''),
        ],
      ),
    );
  }
}

class EventText extends StatelessWidget {
  final String text;
  const EventText(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 3.0),
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(
                  color: context.watch<BaseModel>().themeData.primaryColor,
                  width: 1.0))),
      child: Text(
        this.text,
        style: TextStyle(
          fontSize: 18.0,
          backgroundColor: context.watch<BaseModel>().themeData.backgroundColor,
        ),
      ),
    );
  }
}
