import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soi_koi_nae_v2/common/signup_button.dart';
import 'package:soi_koi_nae_v2/services/update_image_profile.dart';
import 'InputFields.dart';
import 'package:path/path.dart';

class FormSignup extends StatefulWidget {
  @override
  _FormSignupState createState() => _FormSignupState();
}

class _FormSignupState extends State<FormSignup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstnameCtrl = new TextEditingController();
  TextEditingController lastnameCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  TextEditingController conpasswordCtrl = new TextEditingController();
  File _imageFile;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  bool loading;
  final UpdateImageProfile updateImageProfile = UpdateImageProfile();

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value.length < 13 || value.isEmpty) {
      return 'รูปแบบอีเมลล์ไม่ถูกต้องหรือคุณยังไม่ได้กรอกอีเมล';
    } else {
      return null;
    }
  }

  Future uploadImage(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('ีuserprofile/${fileName.toString()}');
    StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot snapshotTask = await task.onComplete;
    String downloadUrl = await snapshotTask.ref.getDownloadURL();

    if (downloadUrl != null) {
      updateImageProfile
          .updateImageProfile(downloadUrl.toString(), context)
          .then((val) {
        print('update image profile success');
        // Navigator.pushReplacementNamed(context, '/home');
        
      }).catchError((e) {
        print('upload error ' + e);
      });
    }
  }

  void startSignup(context) {
    setState(() => loading = true);
    if (_formKey.currentState.validate()) {
      // get data from textfield
      String fname = firstnameCtrl.text.trim();
      String lname = lastnameCtrl.text.trim();
      String email = emailCtrl.text.trim();
      String pass = passwordCtrl.text;
      String conpass = conpasswordCtrl.text;

      // Check password is matched
      if (pass != conpass) {
        setState(() => loading = false);
        print('show alert password not matched');
      } else {
        // start register
        print('signup: $fname, $lname, $email, $pass, $conpass');
        auth.createUserWithEmailAndPassword(email: email, password: pass).then(
            (currentUser) => firestore
                    .collection('users')
                    .document(currentUser.user.uid)
                    .setData({
                  'firstname': fname,
                  'lastname': lname,
                  'email': fname,
                  'uid': currentUser.user.uid
                }).whenComplete(() {
                  uploadImage(context);
                  print('signupsuccess');
                  Navigator.pushReplacementNamed(context, '/home');
                } ));
      }
    }
  }

  // Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  void chooseImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('กล้อง'),
                  onTap: () {
                    setState(() {
                      // file = ImagePicker.pickImage(source: ImageSource.camera);
                      _pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    });
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('คลังรูปภาพ'),
                  onTap: () {
                    setState(() {
                      // file = ImagePicker.pickImage(source: ImageSource.gallery);
                      // Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget showImage(BuildContext context) {
    return Center(
        child: _imageFile == null
            ? Stack(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 75.0,
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Color(0XFFFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/images/user.png',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 4.0,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        child: ClipOval(
                          child: Material(
                            color: Color(0xff5663FF),
                            child: InkWell(
                              onTap: () => chooseImage(context),
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 75.0,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 70.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(
                                // snapshot.data,
                                _imageFile),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 4.0,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        child: ClipOval(
                          child: Material(
                            color: Color(0xff5663FF),
                            child: InkWell(
                              onTap: () => chooseImage(context),
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
  }

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  void dispose() {
    super.dispose();
    firstnameCtrl.clear();
    lastnameCtrl.clear();
    emailCtrl.clear();
    passwordCtrl.clear();
    conpasswordCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                showImage(context),
                InputFieldArea(
                  inputCtrl: firstnameCtrl,
                  label: 'ชื่อ',
                  obscure: false,
                  icon: Icons.person_outline,
                  val: (value) {
                    if (value.isEmpty || value.length < 2)
                      return 'ชื่อห้ามว่างหรือต่ำกว่า 2 ตัวอักษร';
                    return null;
                  },
                ),
                InputFieldArea(
                  inputCtrl: lastnameCtrl,
                  label: 'นามสกุล',
                  obscure: false,
                  icon: Icons.person_outline,
                  val: (value) {
                    if (value.isEmpty || value.length < 2)
                      return 'นามสกุลห้ามว่างหรือต่ำกว่า 2 ตัวอักษร';
                    return null;
                  },
                ),
                InputFieldArea(
                  inputCtrl: emailCtrl,
                  label: 'อีเมล',
                  obscure: false,
                  icon: Icons.person_outline,
                  val: emailValidator,
                ),
                InputFieldArea(
                  inputCtrl: passwordCtrl,
                  label: 'รหัสผ่าน',
                  obscure: true,
                  icon: Icons.person_outline,
                  val: (value) {
                    if (value.isEmpty || value.length < 6)
                      return 'รหัสผ่านห้ามว่างหรือต่ำกว่า 6 ตัวอักษร';
                    return null;
                  },
                ),
                InputFieldArea(
                  inputCtrl: conpasswordCtrl,
                  label: 'ยืนยันรหัสผ่าน',
                  obscure: true,
                  icon: Icons.person_outline,
                  val: (value) {
                    if (value.isEmpty || value.length < 6)
                      return 'รหัสผ่านห้ามว่างหรือต่ำกว่า 6 ตัวอักษร';
                    return null;
                  },
                ),
                SizedBox(height: 28.0),
                InkWell(
                  onTap: () => startSignup(context),
                  child: SignupButton(),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: loading,
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
