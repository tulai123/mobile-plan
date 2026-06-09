class NhanVien {
  final String ten;
  final double luongGross;

  NhanVien({
    required this.ten,
    required this.luongGross,
  });

  Future<double> tinhLuongSauThue(double gross) async {
    await Future.delayed(Duration(seconds: 2));

    if (gross <= 10000000) {
      return gross;
    } else if (gross <= 20000000) {
      return gross * 0.9;
    } else {
      return gross * 0.8;
    }
  }
}

Future<void> main() async {
  List<NhanVien> dsNhanVien = [
    NhanVien(ten: 'An', luongGross: 8000000),
    NhanVien(ten: 'Bình', luongGross: 15000000),
    NhanVien(ten: 'Cường', luongGross: 25000000),
  ];

  for (var nv in dsNhanVien) {
    double luongNet = await nv.tinhLuongSauThue(nv.luongGross);

    print(
      '${nv.ten} | Gross: ${nv.luongGross} | Net: $luongNet',
    );
  }
}