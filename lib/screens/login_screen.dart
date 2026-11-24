import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;
  bool _loading = false;
  bool _isRegisterMode = false;

  

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  Future<void> _login() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      if (_isRegisterMode) {
        await ApiService.register(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (!mounted) return;
        setState(() {
          _loading = false;
          _isRegisterMode = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Compte créé. Vous pouvez maintenant vous connecter.'),
            backgroundColor: Colors.green,
          ),
        );
        return;
      }

      // Appel réel à POST /accounts/login
      await ApiService.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;
      setState(() {
        _loading = false;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: const Color(0xFFB42318),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Erreur de connexion au serveur. Vérifiez WampServer et l\'API.',
          ),
          backgroundColor: Color(0xFFB42318),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ARRIERE-PLAN
          Container(
            height: MediaQuery.sizeOf(context).height * 0.48,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF123456),
                  Color(0xFF0F7890),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(38)),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 26),
                    // LOGO
                    Container(
                      height: 76,
                      width: 76,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Icon(
                        Icons.badge_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Bienvenue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      
                      _isRegisterMode
                          ? 'Crée ton compte pour accéder au CV'
                          : 'Connecte-toi pour découvrir mon univers',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                    ),
                    const SizedBox(height: 44),
                    // FORMULAIRE
                    Card(
                      color: Colors.white,
                      elevation: 14,
                      shadowColor: const Color(0xFF123456).withValues(
                        alpha: 0.14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                        side: const BorderSide(color: Color(0xFFE5EDF5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                
                                _isRegisterMode ? 'Inscription' : 'Connexion',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF17324D),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _isRegisterMode
                                    ? 'Enregistre ton adresse e-mail et ton mot de passe.'
                                    : 'Entre tes identifiants pour continuer.',
                                style: const TextStyle(
                                  color: Color(0xFF65758B),
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              const Text(
                                'Adresse e-mail',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF34465C),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  hintText: 'Tapez votre adresse e-mail',
                                  filled: true,
                                  fillColor: Color(0xFFF5F8FC),
                                  hintStyle: TextStyle(
                                    color: Color(0xFF8A98A9),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Color(0xFF71849A),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFFDCE5EF),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFF0F7890),
                                      width: 1.6,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFFB42318),
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFFB42318),
                                      width: 1.6,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Color(0xFF26384D),
                                ),
                                validator: (value) {
                                  final trimmed = value?.trim() ?? '';
                                  if (trimmed.isEmpty) {
                                    return 'Saisis ton adresse e-mail';
                                  }
                                  if (!trimmed.contains('@') ||
                                      !trimmed.contains('.')) {
                                    return 'Adresse e-mail invalide';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 18),
                              // MOT DE PASSE
                              const Text(
                                'Mot de passe',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF34465C),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _hidePassword,
                                onFieldSubmitted: (_) => _login(),
                                decoration: InputDecoration(
                                  hintText: 'Ton mot de passe',
                                  filled: true,
                                  fillColor: const Color(0xFFF5F8FC),
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF8A98A9),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Color(0xFF71849A),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFDCE5EF),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF0F7890),
                                      width: 1.6,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB42318),
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB42318),
                                      width: 1.6,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _hidePassword = !_hidePassword;
                                      });
                                    },
                                    icon: Icon(
                                      _hidePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: const Color(0xFF71849A),
                                    ),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Color(0xFF26384D),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Saisis ton mot de passe';
                                  }
                                  
                                  if (value.length < 6) {
                                    return '6 caractères minimum requis';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              // BOUTON CONNEXION / INSCRIPTION
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: FilledButton(
                                  onPressed: _loading ? null : _login,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: const Color(0xFF123456),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: _loading
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _isRegisterMode
                                                  ? 'Créer le compte'
                                                  : 'Se connecter',
                                            ),
                                            const SizedBox(width: 9),
                                            const Icon(
                                              Icons.arrow_forward,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              
                              Center(
                                child: TextButton(
                                  onPressed: _loading
                                      ? null
                                      : () {
                                          setState(() {
                                            _isRegisterMode = !_isRegisterMode;
                                          });
                                        },
                                  child: Text(
                                    _isRegisterMode
                                        ? 'Déjà un compte ? Se connecter'
                                        : 'Pas encore de compte ? S\'inscrire',
                                    style: const TextStyle(
                                      color: Color(0xFF0F7890),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}