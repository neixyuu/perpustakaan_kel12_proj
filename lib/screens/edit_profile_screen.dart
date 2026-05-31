import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perpustakaan/l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isLoading = false;
  bool _isLoadingData = true;

  File? _localImageFile;
  String? _currentPhotoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _currentPhotoUrl = user.photoURL;

      // Load additional data from Firestore
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          final data = doc.data()!;
          _phoneController.text = data['phone'] ?? '';
          _addressController.text = data['address'] ?? '';
          // If Firestore has a different name, prefer it
          if (data['name'] != null && data['name'].toString().isNotEmpty) {
            _nameController.text = data['name'];
          }
          if (data['photoUrl'] != null && data['photoUrl'].toString().isNotEmpty) {
            _currentPhotoUrl = data['photoUrl'];
          }
        }
      } catch (_) {
        // Firestore doc may not exist yet – that's okay
      }
    }
    if (mounted) setState(() => _isLoadingData = false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final source = await showModalBottomSheet<ImageSource>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (ctx) {
          final isDark = Theme.of(ctx).brightness == Brightness.dark;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(ctx)!.photoSource,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Theme.of(ctx).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.camera_alt_rounded,
                          color: Theme.of(ctx).primaryColor),
                    ),
                    title: Text(AppLocalizations.of(ctx)!.camera, style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                    subtitle: Text(AppLocalizations.of(ctx)!.takeNewPhoto, style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                    onTap: () => Navigator.pop(ctx, ImageSource.camera),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.photo_library_rounded,
                          color: Colors.orange),
                    ),
                    title: Text(AppLocalizations.of(ctx)!.gallery, style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                    subtitle: Text(AppLocalizations.of(ctx)!.pickFromGallery, style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                    onTap: () => Navigator.pop(ctx, ImageSource.gallery),
                  ),
                ],
              ),
            ),
          );
        },
      );

      if (source == null) return;

      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        setState(() {
          _localImageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.imagePickFailed(e.toString()))),
      );
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final address = _addressController.text.trim();

    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? finalPhotoUrl = _currentPhotoUrl;

        // If a new image was picked, store its local path
        // (Replace with Firebase Storage upload for production)
        if (_localImageFile != null) {
          finalPhotoUrl = _localImageFile!.path;
        }

        // Update Firebase Auth display name & photo
        await user.updateDisplayName(name);
        if (finalPhotoUrl != null) {
          await user.updatePhotoURL(finalPhotoUrl);
        }

        // Update Firestore user document with all fields
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'uid': user.uid,
          'name': name,
          'email': user.email,
          'phone': phone,
          'address': address,
          'photoUrl': finalPhotoUrl,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.profileUpdated)),
          );
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.profileUpdateFailed(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.editProfile,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoadingData
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // Avatar with camera icon
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: primary.withOpacity(0.4),
                                width: 4,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor:
                                  isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                              backgroundImage: _localImageFile != null
                                  ? FileImage(_localImageFile!)
                                  : (_currentPhotoUrl != null &&
                                          _currentPhotoUrl!.isNotEmpty
                                      ? (_currentPhotoUrl!.startsWith('/')
                                          ? FileImage(File(_currentPhotoUrl!))
                                          : NetworkImage(_currentPhotoUrl!)
                                              as ImageProvider)
                                      : null),
                              child: (_localImageFile == null &&
                                      (_currentPhotoUrl == null ||
                                          _currentPhotoUrl!.isEmpty))
                                  ? Icon(Icons.person,
                                      size: 50, color: Colors.grey.shade500)
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: primary,
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.changePhotoHint,
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade500),
                    ),

                    const SizedBox(height: 32),

                    // Name field
                    _buildFieldLabel(AppLocalizations.of(context)!.fullName),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return AppLocalizations.of(context)!.nameRequired;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enterFullName,
                        prefixIcon:
                            const Icon(Icons.person_outline, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email (locked)
                    _buildFieldLabel(AppLocalizations.of(context)!.email),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue:
                          FirebaseAuth.instance.currentUser?.email,
                      enabled: false,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.mail_outline, size: 20),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                        ),
                        filled: true,
                        fillColor: isDark
                            ? Colors.grey.shade900
                            : Colors.grey.shade100,
                        suffixIcon: const Icon(Icons.lock_outline,
                            color: Colors.grey, size: 18),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.emailCannotChange,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade500),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Phone field
                    _buildFieldLabel(AppLocalizations.of(context)!.phoneNumber),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.phoneHint,
                        prefixIcon:
                            const Icon(Icons.phone_outlined, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Address field
                    _buildFieldLabel(AppLocalizations.of(context)!.address),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enterAddress,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 40),
                          child:
                              Icon(Icons.location_on_outlined, size: 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Save button
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
                            : Text(AppLocalizations.of(context)!.saveChanges,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white70
              : Colors.black87,
        ),
      ),
    );
  }
}