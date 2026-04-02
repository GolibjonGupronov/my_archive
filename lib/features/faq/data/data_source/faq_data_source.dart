import 'package:dio/dio.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/faq/data/models/faq_model.dart';

abstract class FaqDataSource {
  Future<List<FaqModel>> faqList();
}

class FaqDataSourceImpl extends FaqDataSource {
  final Dio dio;

  FaqDataSourceImpl({required this.dio});

  @override
  Future<List<FaqModel>> faqList() async {
    final response = await dio.mock(data: _faqList).get(ApiUrls.faqList);
    return (response.data as List<dynamic>).map((e) => FaqModel.fromJson(e)).toList();
  }
}

List<FaqModel> get _faqList => [
      FaqModel(
        question: "Bu ilova nima uchun mo'ljallangan?",
        answer:
            "Bu ilova sizning shaxsiy ma'lumotlaringiz, rasmlaringiz va boshqa arxiv materiallarini xavfsiz saqlash va tashkil qilish uchun yaratilgan.",
      ),
      FaqModel(
        question: "Qanday qilib profil rasmini o'zgartirish mumkin?",
        answer:
            "Profil bo'limiga kiring, 'Rasmni o'zgartirish' tugmasini bosing va yangi rasmni tanlang. O'zgarishlar avtomatik saqlanadi.",
      ),
      FaqModel(
        question: "Bildirishnomalarni qanday yoqish yoki o'chirish mumkin?",
        answer:
            "Sozlamalar bo'limida 'Bildirishnomalar' opsiyasini toping va uni yoqing yoki o'chiring. Bu sizning xabarlarga o'z vaqtida javob berishingizga yordam beradi.",
      ),
      FaqModel(
        question: "Ilova bilan bog'liq muammolar bo'lsa, qanday yordam olish mumkin?",
        answer: "FAQ bo'limini tekshiring yoki qo'llab-quvvatlash xizmatiga email yuboring. Biz sizga tez orada javob beramiz.",
      ),
    ];
