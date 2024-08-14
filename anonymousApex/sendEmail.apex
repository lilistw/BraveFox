String address = 'lili.st.work@gmail.com';
String subject = 'Speaker Confirmation';
String body = 'Thank you for speaking at the conference.';
String[]  addresses = new String[]{},
          subjects = new String[]{},
          messages = new String[]{};
addresses.add(address);
subjects.add(subject);
messages.add(body);
EmailManager.sendMail(addresses, subjects, messages);