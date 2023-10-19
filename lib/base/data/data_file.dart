import '../models/model_booking.dart';
import '../models/model_chat.dart';
import '../models/model_country.dart';
import '../models/model_message.dart';
import '../models/model_review.dart';

class DataFile {
  static List<ModelCountry> countryList = [
    ModelCountry('image_fghanistan.jpg', 'Afghanistan (AF)', '+93'),
    ModelCountry('image_ax.jpg', 'Aland Islands (AX)', '+358'),
    ModelCountry('image_albania.jpg', 'Albania (AL)', '+355'),
    ModelCountry('image_andora.jpg', 'Andorra (AD)', '+376'),
    ModelCountry('image_islands.jpg', 'Aland Islands (AX)', '+244'),
    ModelCountry('image_angulia.jpg', 'Anguilla (AL)', '+1'),
    ModelCountry('image_armenia.jpg', 'Armenia (AN)', '+374'),
    ModelCountry('image_austia.jpg', 'Austria (AT)', '+372'),
  ];

  static List<ModelBooking> bookingList = [
    ModelBooking('Cleaning', 'Today, 11:00 am', 'booking_owner.png', 'Mendy Wilson', 'Approved', 'Today'),
    ModelBooking('Cleaning', 'Today, 08:00 am', 'booking_owner1.png', 'Jenny Winget', 'Approved', 'Today'),
    ModelBooking('Cleaning', 'Today, 07:00 am', 'booking_owner2.png', 'Jacob Jones', 'Approved', 'Today'),
    ModelBooking(
        'Cleaning', 'Yesterday, 06:00 am', 'booking_owner3.png', 'Ronald Richards', 'Approved', 'Yesterday')
  ];

  static List<ModelReview> reviewList = [
    ModelReview('booking_owner.png', 'Mendy Wilson'),
    ModelReview('booking_owner1.png', 'Leslie Alexander'),
    ModelReview('booking_owner2.png', 'Ralph Edwards'),
    ModelReview('booking_owner3.png', 'Ronald Richards')
  ];

  static List<ModelChat> chatList = [
    ModelChat('chat1.png', 'Nick Jonas', '1 h ago'),
    ModelChat('chat2.png', 'Leslie Alexander', '1 d ago'),
    ModelChat('chat3.png', 'Robert Fox', '1 d ago'),
    ModelChat('chat4.png', 'Ralph Edwards', '3 d ago'),
    ModelChat('chat5.png', 'Arlene McCoy', '4 d ago'),
    ModelChat('chat6.png', 'Eleanor Pena', '5 d ago')
  ];

  static List<ModelMessage> messageList = [
    ModelMessage('Lorem ipsum dolor sit amet', '01:00 AM', 'receiver'),
    ModelMessage('From its medieval origins', '01:01 AM', 'sender'),
    ModelMessage('Duis aute irure dolor in reprehenderit', '01:02 AM', 'receiver'),
    ModelMessage('Reserunt mollit anim id est labor.', '01:03 AM', 'sender'),
    ModelMessage('voluptate velit esse cillum', '01:03 AM', 'receiver')
  ];
}
