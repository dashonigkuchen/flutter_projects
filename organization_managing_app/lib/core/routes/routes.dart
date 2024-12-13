import 'package:go_router/go_router.dart';
import 'package:organization_managing_app/core/routes/route_names.dart';
import 'package:organization_managing_app/pages/login_page.dart';
import 'package:organization_managing_app/pages/members_page.dart';
import 'package:organization_managing_app/pages/register_page.dart';
import 'package:organization_managing_app/pages/splash_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: RouteNames.splash,
      path: "/",
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: RouteNames.login,
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: RouteNames.register,
      path: "/register",
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      name: RouteNames.members,
      path: "/members",
      builder: (context, state) => const MembersPage(),
    ),
  ],
);
