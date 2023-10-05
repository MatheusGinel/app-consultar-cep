import 'package:cadastro_cep/page/consultar_cep_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.cyan, textTheme: GoogleFonts.robotoTextTheme()),
      home: const ConsultarCepPage(),
    );
  }
}
