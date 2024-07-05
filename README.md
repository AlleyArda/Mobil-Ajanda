# Dil
![Swift](https://img.shields.io/badge/language-Swift-orange.svg)

# <h1 style="color:blue;">MeetingScheduler</h1>

MeetingScheduler, kullanıcıların toplantılarını ve şoförlerin görevlerini yönetmek için kullanılan bir macOS uygulamasıdır. Bu proje, MVVM mimarisi ile geliştirilmiş ve SwiftUI ile kullanıcı arayüzü tasarlanmıştır.

## Özellikler

- Kullanıcı giriş sistemi (Başkan ve Şoför rolleri)
- Başkan ve Şoför için ayrı arayüzler
- Kullanıcıya özel toplantı ve görev listeleri
- Toplantı detaylarının görüntülenmesi

## Kurulum

### Gereksinimler

- macOS 11.0 veya üstü
- Xcode 12.0 veya üstü

### Adımlar

1. Bu repository'i klonlayın:
   ```bash
   git clone https://github.com/AlleyArda/MeetingScheduler.git
   

 ----------------------------------------------------------------------
2.	Xcode’u açın ve projeyi yükleyin:
      cd MeetingScheduler
      open MeetingScheduler.xcodeproj

---------------------------------------------------------------------- 
3.	Projeyi derleyin ve çalıştırın.

----------------------------------------------------------------------

Kullanım

Giriş Yapma

Uygulamayı başlattığınızda, kullanıcı adı ve şifre ile giriş yapmanız gerekmektedir. Örnek kullanıcı adı ve şifreler ''mock'' datalar dosyasında bulunmaktadır

Toplantılar ve Görevler

Başkan olarak giriş yaptığınızda, kendi toplantılarınızı görebilirsiniz. Şoför olarak giriş yaptığınızda, taşımanız gereken görevleri görüntüleyebilirsiniz.



MVVM Mimarisi

	•	Model: Kullanıcı ve toplantı verilerini tanımlar.
	•	UserModel.swift
	•	MockUserDataSource.swift
	•	ViewModel: Verileri işler ve View’a sunar.
	•	UserViewModel.swift
	•	MeetingViewModel.swift
	•	View: Kullanıcı arayüzünü oluşturur.
	•	LoginView.swift
	•	ChairmanView.swift
	•	DriverView.swift

 Dosya Yapısı

 MeetingScheduler
├── MeetingSchedulerApp.swift
├── Model
│   ├── UserModel.swift
│   ├── MockUserDataSource.swift
├── ViewModel
│   ├── UserViewModel.swift
│   ├── MeetingViewModel.swift
├── View
│   ├── LoginView.swift
│   ├── ChairmanView.swift
│   ├── DriverView.swift

Katkıda Bulunma

Katkıda bulunmak isterseniz, lütfen bir issue oluşturun veya bir pull request gönderin.
