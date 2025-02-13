import 'package:flutter/material.dart';

class CreateLessonScreen extends StatefulWidget {
  @override
  _CreateLessonScreenState createState() => _CreateLessonScreenState();
}

class _CreateLessonScreenState extends State<CreateLessonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedSubject = 'Mathematics';
  String _selectedLanguage = 'English';
  final List<String> _attachments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Lesson',
            style: TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 19, 52, 175),
                Color.fromARGB(255, 84, 96, 191)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_titleController, 'Lesson Title', Icons.title),
              const SizedBox(height: 16),
              _buildDropdown(
                  'Subject',
                  ['Mathematics', 'Science', 'English', 'History'],
                  _selectedSubject, (value) {
                setState(() {
                  _selectedSubject = value!;
                });
              }),
              const SizedBox(height: 16),
              _buildTextField(
                  _descriptionController, 'Description', Icons.description,
                  maxLines: 2),
              const SizedBox(height: 16),
              _buildTextField(
                  _contentController, 'Lesson Content', Icons.article,
                  maxLines: 10),
              const SizedBox(height: 16),
              _buildDropdown(
                  'Language',
                  ['English', 'Spanish', 'French', 'German'],
                  _selectedLanguage, (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              }),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _addAttachment,
                icon: const Icon(Icons.attach_file),
                label: const Text('Add Attachment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 116, 164, 253),
                  foregroundColor: Colors.white,
                ),
              ),
              if (_attachments.isNotEmpty) _buildAttachments(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitLesson,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child:
                    const Text('Create Lesson', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      maxLines: maxLines,
      validator: (value) =>
          (value?.isEmpty ?? true) ? 'Please enter $label' : null,
    );
  }

  Widget _buildDropdown(String label, List<String> items, String selectedValue,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildAttachments() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attachments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _attachments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_attachments[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeAttachment(index),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addAttachment() {
    setState(() {
      _attachments.add('Sample_attachment_${_attachments.length + 1}.pdf');
    });
  }

  void _removeAttachment(int index) {
    setState(() {
      _attachments.removeAt(index);
    });
  }

  void _submitLesson() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lesson created successfully!')),
      );
      Navigator.pop(context);
    }
  }
}
