import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_app_irfans/core/extensions/build_context_ext.dart';

import '../../../core/components/custom_scaffold.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/models/responses/auth_response_model.dart';
import '../../auth/bloc/logout/logout_bloc.dart';
import '../../auth/pages/login_page.dart';
import '../widgets/profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackButton: false,
      toolbarHeight: 110.0,
      appBarTitle: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            child: Image.network(
              'https://i.pravatar.cc/200',
              width: 64.0,
              height: 64.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          SizedBox(
            width: context.deviceWidth - 160.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<AuthResponseModel>(
                  future: AuthLocalDataSource().getAuthData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "Halo, ${snapshot.data!.user.name}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    } else {
                      return const Text(
                        "Halo, Irfan Shiddiq",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                  },
                ),
                const SizedBox(height: 8,),
                FutureBuilder<AuthResponseModel>(
                  future: AuthLocalDataSource().getAuthData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.user.email,
                        style: const TextStyle(
                           color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    } else {
                      return const Text(
                        '@irfams99',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                  },
                ),

                // Text(
                //   'Halo, Saiful Bahri',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 20,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // Text(
                //   '@codewithbahri',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 12,
                //     fontWeight: FontWeight.w400,
                //   ),
                //   overflow: TextOverflow.ellipsis,
                // ),
              ],
            ),
          ),
          const Spacer(),
          // IconButton(
          //   onPressed: () {
          //     context.pushAndRemoveUntil(const LoginPage(), (route) => false);
          //   },
          //   icon: Assets.icons.logout.image(width: 24.0),
          // ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          const SizedBox(height: 16.0),
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          ProfileMenu(
            label: 'Edit Profile',
            onPressed: () {},
          ),
          ProfileMenu(
            label: 'Help',
            onPressed: () {},
          ),
          ProfileMenu(
            label: 'Privacy & Policy',
            onPressed: () {},
          ),
          ProfileMenu(
            label: 'Term of Service',
            onPressed: () {},
          ),
          const SizedBox(height: 16.0),
          ProfileMenu(
            label: 'Logout',
            onPressed: () {
              context.read<LogoutBloc>().add(const LogoutEvent.logout());
              AuthLocalDataSource().deleteAuthData();
              context.pushReplacement(const LoginPage());
              // context.pushAndRemoveUntil(const LoginPage(), (route) => false);
            },
          ),
        ],
      ),
    );
  }
}


// class LogoutWidget extends StatefulWidget {
//   const LogoutWidget({
//     super.key,
//   });

//   @override
//   State<LogoutWidget> createState() => _LogoutWidgetState();
// }

// class _LogoutWidgetState extends State<LogoutWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//           onPressed: () {
//             context.read<LogoutBloc>().add(const LogoutEvent.logout());
//             AuthLocalDataSource().deleteAuthData();
//             context.pushReplacement(const LoginPage());
//           },
//           child: const Text('Logout')), //const Center(child: Text('Logout')),
//     );
//   }
// }
