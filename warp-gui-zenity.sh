#!/bin/bash

# Fungsi untuk setiap mode
family_mode() {
    zenity --info --text="Family Mode Full diaktifkan.\nLayanan telah dibatasi untuk konten aman keluarga."
    pkexec warp-cli set-mode family
    pkexec warp-cli connect
}

malware_mode() {
    zenity --info --text="Malware Mode diaktifkan.\nPerlindungan malware telah diaktifkan."
    pkexec warp-cli set-mode malware
    pkexec warp-cli connect
}

turn_off() {
    zenity --info --text="Layanan telah dimatikan."
    pkexec warp-cli disconnect
}

# Memulai layanan WARP
start_service() {
    pkexec systemctl start warp-svc
    if systemctl is-active --quiet warp-svc; then
        zenity --info --text="Layanan warp-svc telah dimulai."
    else
        zenity --error --text="Gagal memulai layanan warp-svc."
    fi
}

# Menghentikan layanan WARP
stop_service() {
    pkexec systemctl stop warp-svc
    if ! systemctl is-active --quiet warp-svc; then
        zenity --info --text="Layanan warp-svc telah dihentikan."
    else
        zenity --error --text="Gagal menghentikan layanan warp-svc."
    fi
}

# Submenu Mode (Family, Malware, Off)
submenu_mode() {
    while true; do
        MODE_OPTION=$(zenity --list --title="Pilih Mode WARP" \
            --column="Mode" --width=300 --height=300 \
            "Family Mode Full" \
            "Malware Mode" \
            "Off" \
            "Kembali ke Menu Utama")

        case $MODE_OPTION in
            "Family Mode Full")
                family_mode
                ;;
            "Malware Mode")
                malware_mode
                ;;
            "Off")
                turn_off
                ;;
            "Kembali ke Menu Utama")
                break
                ;;
            *)
                zenity --error --text="Pilihan tidak valid. Silakan coba lagi."
                ;;
        esac
    done
}

# Menu utama dengan Zenity
while true; do
    OPTION=$(zenity --list --title="Cloudflare WARP GUI" \
        --column="Menu Utama" --width=300 --height=400 \
        "Atur Mode (Family, Malware, Off)" \
        "Start Service (warp-svc)" \
        "Stop Service (warp-svc)" \
        "Connect WARP" \
        "Disconnect WARP" \
        "Status" \
        "Keluar")

    case $OPTION in
        "Atur Mode (Family, Malware, Off)")
            submenu_mode
            ;;
        "Start Service (warp-svc)")
            start_service
            ;;
        "Stop Service (warp-svc)")
            stop_service
            ;;
        "Connect WARP")
            pkexec warp-cli connect
            zenity --info --text="Cloudflare WARP berhasil dihubungkan."
            ;;
        "Disconnect WARP")
            pkexec warp-cli disconnect
            zenity --info --text="Cloudflare WARP telah diputuskan."
            ;;
        "Status")
            STATUS=$(warp-cli status)
            zenity --info --title="Status WARP" --text="$STATUS"
            ;;
        "Keluar")
            exit 0
            ;;
        *)
            zenity --error --text="Pilihan tidak valid. Silakan coba lagi."
            ;;
    esac
done
