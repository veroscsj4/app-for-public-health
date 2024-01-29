import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';
import '../../constants/general_functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenomeDescription extends StatefulWidget {
  String genome;

  GenomeDescription({required this.genome});

  @override
  GenomeDescriptionState createState() => GenomeDescriptionState();
}

class GenomeDescriptionState extends State<GenomeDescription> {
  Future<String>? information;
  Future<String>? chromosome;
  Future<List<String>>? link;

  @override
  void initState() {
    super.initState();
    fetchData();
    //information = getInformation(widget.genome, 'genome');
  }

  Future<void> fetchData() async {
    try {
      Map<String, dynamic>? result =
          await getInformation(widget.genome, 'genome');
      information = Future.value(result?['information']?.toString());
      chromosome = Future.value(result?['chromosome']?.toString());
      link = Future.value(result?['link']);
      setState(() {});
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(information);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gene Description',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('${widget.genome}',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 10, right: 10),
                  child: const FaIcon(
                    FontAwesomeIcons.dna,
                    color: whiteColor,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FutureBuilder<String>(
                    future: chromosome,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        if (snapshot.data != null) {
                          return Text(
                            'The variant was found on the chromosome ' +
                                snapshot.data.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          );
                        } else {
                          return Text(
                            'No information available',
                            style: Theme.of(context).textTheme.bodySmall,
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<String>(
              future: information,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (snapshot.data != null) {
                    return Text(
                      snapshot.data.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  } else {
                    return Text('No information available',
                        style: Theme.of(context).textTheme.bodySmall);
                  }
                }
              },
            ),
            const SizedBox(height: 20),
            FutureBuilder<List>(
              future: link,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (snapshot.data != null) {
                    List<String> linkList = snapshot.data as List<String>;

                    if (linkList.isNotEmpty) {

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Do you want to learn more about the variant? ',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            'You can find additional information here. ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          for (String link in linkList)                         
                            GestureDetector(
                              onTap: () {
                                launchURL(link);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: lightGreyColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 10),
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 8),  // Adjust the spacing between icon and text
                                    Text(
                                      link,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    FaIcon(
                                        FontAwesomeIcons.arrowCircleRight,
                                        color:primaryColor, 
                                        size: 15.0,
                                      ),
                                  ],
                                )
                              ),
                            ),
                        ],
                      );
                    } else {
                      return Text('No information available',
                          style: Theme.of(context).textTheme.bodySmall);
                    }
                  } else {
                    return Text('No information available',
                        style: Theme.of(context).textTheme.bodySmall);
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
