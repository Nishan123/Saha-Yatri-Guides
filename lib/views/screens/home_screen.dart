import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:saha_yatri_guides/services/booking_request.dart';
import 'package:saha_yatri_guides/services/chat_service.dart';
import 'package:saha_yatri_guides/views/widgets/custom_choice_chip.dart';
import 'package:saha_yatri_guides/views/widgets/home_appbar.dart';
import 'package:saha_yatri_guides/views/widgets/search_bar_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: const HomeAppbar(username: "Jamal"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarField(
                hintText: "Search your requests",
                prefixIcon: const Icon(FeatherIcons.search),
                controller: searchController,
              ),
              const CustomChoiceChip(),
              const SizedBox(
                height: 6,
              ),
              // StreamBuilder to fetch and stream Firestore data
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(
                        'guide_request') // Replace with your collection name
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('No booking requests available'));
                  }

                  // Loop through the documents in the snapshot
                  final documents = snapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final docId = document.id;
                        final clientName = document['client_name'] ?? 'Unknown';
                        final clientId = document['clientId'] ?? 'unknown';
                        final phone = document['phone'] ?? 'N/A';
                        final destination = document['destination'] ?? 'N/A';
                        final noOfPeople = document['no_of_people'] ?? 'N/A';
                        final date = document['date'] ?? 'N/A';

                        return BookingRequest(
                          clientId: clientId,
                          docId: docId,
                          clientName: clientName,
                          phone: phone,
                          destination: destination,
                          date: date,
                          noOfPeople: noOfPeople,
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BookingRequest extends StatelessWidget {
  final String clientName;
  final String docId;
  final String clientId;
  final String phone;
  final String destination;
  final String noOfPeople;
  final String date;
  const BookingRequest({
    super.key,
    required this.clientName,
    required this.clientId,
    required this.phone,
    required this.destination,
    required this.noOfPeople,
    required this.date,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(12), // Apply border radius here
                  child: Image.asset(
                    "assets/bishal.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    clientName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DetailsWidget(
                    icon: Icons.phone,
                    text: phone,
                  ),
                  DetailsWidget(
                    icon: Icons.landscape_outlined,
                    text: destination,
                  ),
                  DetailsWidget(
                    icon: Icons.people_alt_outlined,
                    text: noOfPeople,
                  ),
                  DetailsWidget(
                    icon: Icons.date_range_outlined,
                    text: date,
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  ChatService().sendMessage(clientId,
                      "Have approved your message and see you soon Early in the morning");
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: const Center(
                    child: Text(
                      "Accept",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
            InkWell(
              onTap: () {
                BookingService().rejectBooking("guide_request", docId);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.red),
                child: const Center(
                  child: Text(
                    "Reject",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class DetailsWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const DetailsWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(text),
        ],
      ),
    );
  }
}
