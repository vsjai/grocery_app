import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "WALL",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              "PEPAR",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      color: Theme.of(context).primaryColor,
                      height: 100,
                    ),
                    Container(
                      color: Colors.white,
                      height: 100,
                    )
                  ],
                ),
              ),
              Positioned(
                top: 50,
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text("main"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
