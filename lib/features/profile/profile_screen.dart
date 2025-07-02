import 'package:ecommerce/features/auth/cubit/auth_cubit.dart';
import 'package:ecommerce/features/auth/cubit/logout.dart';
import 'package:ecommerce/features/auth/screens/login_screen.dart';
import 'package:ecommerce/features/profile/cubit/addres_cubit.dart';
import 'package:ecommerce/features/profile/cubit/addres_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff080020),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Addresses Details',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.add_location, color: Colors.white, size: 20),
            ],
          ),

          const SizedBox(height: 12),

          /// ✅ محتوى العناوين
          Expanded(
            child: BlocBuilder<AddressCubit, AddressState>(
              builder: (context, state) {
                if (state is AddressLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (state is AddressError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is AddressLoaded) {
                  final addresses = state.addresses;

                  if (addresses.isEmpty) {
                    return const Center(
                      child: Text(
                        'لا توجد عناوين مضافة',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return Column(
                        children: [
                          AddressRowDetails(
                            label: 'Home',
                            value: address.home,
                            icon: Icons.home,
                          ),
                          AddressRowDetails(
                            label: 'Details',
                            value: address.details,
                            icon: Icons.description,
                          ),
                          AddressRowDetails(
                            label: 'Phone',
                            value: address.phone,
                            icon: Icons.phone,
                          ),
                          AddressRowDetails(
                            label: 'City',
                            value: address.city,
                            icon: Icons.location_city,
                          ),
                          const SizedBox(height: 12),
                          Divider(
                            color: Colors.white30,
                            indent: 20,
                            endIndent: 20,
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  );
                }

                return const SizedBox(); // Default empty state
              },
            ),
          ),

          /// ✅ زر تسجيل الخروج
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  logoutUser(
                    context, // تمرير السياق هنا
                  ).then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => AuthCubit(),
                          child: const LoginScreen(),
                        ),
                      ),
                    );
                  });
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'تسجيل الخروج',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressRowDetails extends StatelessWidget {
  const AddressRowDetails({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff1c1c3c),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Text(
              '$label:',
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
