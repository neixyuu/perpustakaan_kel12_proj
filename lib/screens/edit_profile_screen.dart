<<<<<<< Updated upstream
=======
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
<<<<<<< Updated upstream
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Profil', style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
=======
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  bool _isLoading = false;
  
  File? _localImageFile; // Stores the newly picked image locally
  String? _currentPhotoUrl; // Keeps track of current remote photo URL

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _nameController.text = user?.displayName ?? '';
    _currentPhotoUrl = user?.photoURL;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // Method to pick an image from the device gallery
  Future<void> _pickImage() async {
    
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70, // Compresses image to save bandwidth
      );

      if (pickedFile != null) {
        setState(() {
          _localImageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil gambar: $e')),
      );
    }
  }

  Future<void> _saveProfile() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama tidak boleh kosong.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? finalPhotoUrl = _currentPhotoUrl;

        // OPTIONAL: If you have Firebase Storage set up, upload your file here 
        // and assign the download URL to finalPhotoUrl.
        // For local storage persistence placeholder:
        if (_localImageFile != null) {
          finalPhotoUrl = _localImageFile!.path; 
        }

        // Update Firebase Auth details
        await user.updateDisplayName(name);
        if (finalPhotoUrl != null) {
          await user.updatePhotoURL(finalPhotoUrl);
        }

        // Update user properties inside Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'name': name,
          'photoUrl': finalPhotoUrl,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil berhasil diperbarui! 🎉')),
          );
          Navigator.pop(context); // Return back to profile overview screen
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengubah profil: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Ubah Profil',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),
            
            // Interactive Avatar Stack with Camera Badge Icon
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        width: 4,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: _localImageFile != null
                          ? FileImage(_localImageFile!)
                          : (_currentPhotoUrl != null
                              ? NetworkImage(_currentPhotoUrl!)
                              : const AssetImage('assets/default_avatar.png')) as ImageProvider,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
>>>>>>> Stashed changes
                    ),
                  ),
                ],
              ),
            ),
<<<<<<< Updated upstream
            const SizedBox(height: 32),
            _buildTextField('Nama Lengkap', 'Admin Perpustakaan'),
            const SizedBox(height: 20),
            _buildTextField('Email', 'admin@perpuspalembang.go.id', isReadOnly: true),
            const SizedBox(height: 20),
            _buildTextField('No. Telepon', '0812-3456-7890'),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Simpan Perubahan'),
=======
            
            const SizedBox(height: 32),
            
            // Profile Input Form Fields
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel('Nama Lengkap'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama lengkap Anda',
                      prefixIcon: const Icon(Icons.person_outline, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  _buildFieldLabel('Email'),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: FirebaseAuth.instance.currentUser?.email,
                    enabled: false, // Locked field
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail_outline, size: 20),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      filled: true,
                      fillColor: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                      suffixIcon: const Icon(Icons.lock_outline, color: Colors.grey, size: 18),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email tidak dapat diubah',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 40),

                  // Submission Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveProfile,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Simpan Perubahan'),
                    ),
                  ),
                ],
>>>>>>> Stashed changes
              ),
            ),
          ],
        ),
      ),
    );
  }

<<<<<<< Updated upstream
  Widget _buildTextField(String label, String initialValue, {bool isReadOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: initialValue),
          readOnly: isReadOnly,
          decoration: InputDecoration(
            filled: true,
            fillColor: isReadOnly ? Colors.grey.shade100 : Colors.white,
          ),
        ),
      ],
=======
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white70 
            : Colors.black87,
      ),
>>>>>>> Stashed changes
    );
  }
}