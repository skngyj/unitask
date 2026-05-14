import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/core/extensions/build_context_extension.dart';
import 'package:unitask/app/router/app_page.dart';
import 'package:unitask/core/models/result.dart';
import 'package:unitask/features/auth/auth_provider.dart';
import 'package:unitask/ui/common/label_text_field.dart';
import 'package:unitask/ui/common/text_divider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = .new();
  final TextEditingController _pwController = .new();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final email = _emailController.text.trim();
    final password = _pwController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      context.showSnackbar('이메일 또는 비밀번호를 입력해주세요', isError: true);
      return;
    }

    final result = await ref.read(authProvider.notifier).login(
      email: email,
      password: password,
    );

    switch (result) {
      case Success():
        if (mounted) context.goNamed(AppPage.home.name);
      case Failure(:final exception):
        if (mounted) {
          context.showSnackbar(
            exception.toString(),
            isError: true,
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(authProvider).isLoading;

    return Scaffold(
      body: Padding(
        padding: .all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: .min,
                spacing: 20,
                children: [
            Column(
            children: [
            Icon(LucideIcons.graduationCap, size: 50),
            Text(
              'UniTask',
              style: TextStyle(fontSize: 28, fontWeight: .bold),
            ),
            Text('과제 관리를 스마트하게'),
            ],
          ),

          // 간격 확보를 위한 공백 추가
          const SizedBox(height: 30),

          LabelTextField(
            controller: _emailController,
            label: '이메일',
            hintText: 'example@naver.com',
            icon: LucideIcons.mail,
          ),

          Column(
            children: [
              LabelTextField(
                controller: _pwController,
                label: '비밀번호',
                hintText: '000000',
                icon: LucideIcons.lockKeyhole,
                enableObscure: true,
              ),
              Align(
                alignment: .centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('비밀번호를 잊으셨나요?'),
                ),
              ),
            ],
          ),

          SizedBox(
            width: .infinity,
            child: ElevatedButton.icon(
              onPressed: loading ? null : _onLogin,
              icon: loading ? SizedBox.square(
                dimension: 14,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
              : null,
              label: const Text(
              '로그인',
              style: TextStyle(fontWeight: .bold, fontSize: 20),
            ),
          ),
        ),

        const TextDivider(text: '또는'),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: .min,
          children: [
            Text('계정이 없으신가요?'),
            TextButton(
              onPressed: () {
                context.pushNamed(AppPage.signup.name);
              },
              child: const Text('회원가입'),
            ),
          ],
        ),
        ],
      ),
    ),
    ),
    ),
    );
  }
}