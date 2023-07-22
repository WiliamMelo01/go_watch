import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
const HeaderWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SizedBox(
                width: double.infinity,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipOval(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Image.network(
                                  'https://res.cloudinary.com/dblxw7p0c/image/upload/c_pad,b_auto:predominant,fl_preserve_transparency/v1689708749/transferir_e2s9bh.jpg?_s=public-apps',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            "Olá Anna",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                          subtitle: Text(
                            'Seja bem vinda',
                            style: GoogleFonts.inter(
                                color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Container(
                          width: 40,
                          height: 40,
                          color: Colors.white,
                          child: const Icon(Icons.notifications_outlined, color: Color.fromRGBO(247, 37, 133, 1)),
                        ),
                      )
                    ],
                  ),
                ),
              );
  }
}