#!/bin/bash

# --- 1. FUNGSI PEMILIHAN BAHASA Awal (GUI) ---
select_language() {
    LANGUAGE_CHOICE=$(zenity --list --title="Pilih Bahasa / Select Language" \
        --column="Kode" --column="Bahasa / Language" --width=350 --height=200 \
        "id" "Bahasa Indonesia" \
        "en" "English" \
        --text="Silakan pilih bahasa yang ingin Anda gunakan:\nPlease select the language you wish to use:")

    # Keluar dari skrip jika pengguna menekan 'Cancel' atau menutup jendela
    if [ $? -ne 0 ] || [ -z "$LANGUAGE_CHOICE" ]; then
        exit 0
    fi

    # Mengembalikan kode bahasa yang dipilih
    echo "$LANGUAGE_CHOICE"
}

# --- 2. FUNGSI MEMUAT TEKS BERDASARKAN BAHASA ---
load_language_texts() {
    LANGUAGE_CODE="$1"

    if [ "$LANGUAGE_CODE" == "en" ]; then
        # English Labels
        LANG_TITLE="Cloudflare WARP GUI"
        LANG_MENU_1="Set Mode (Family, Malware, Off)"
        LANG_MENU_2="Start Service (warp-svc)"
        LANG_MENU_3="Stop Service (warp-svc)"
        LANG_MENU_4="Connect WARP"
        LANG_MENU_5="Disconnect WARP"
        LANG_MENU_6="Status"
        LANG_MENU_7="Exit"
        LANG_INFO_FAMILY="Family Mode Full enabled.\nServices have been restricted to family-safe content."
        LANG_INFO_MALWARE="Malware Mode enabled.\nMalware protection has been activated."
        LANG_INFO_OFF="Service has been turned off."
        LANG_INFO_SVC_START="The warp-svc service has been started."
        LANG_ERROR_SVC_START="Failed to start the warp-svc service."
        LANG_INFO_SVC_STOP="The warp-svc service has been stopped."
        LANG_ERROR_SVC_STOP="Failed to stop the warp-svc service."
        LANG_SUB_1="Family Mode Full"
        LANG_SUB_2="Malware Mode"
        LANG_SUB_3="Off"
        LANG_SUB_4="Back to Main Menu"
        LANG_INFO_CONNECT="Cloudflare WARP successfully connected."
        LANG_INFO_DISCONNECT="Cloudflare WARP has been disconnected."
        LANG_ERROR_INVALID="Invalid choice. Please try again."
    else
        # Indonesian Labels (Default/Fallback)
        LANG_TITLE="Cloudflare WARP GUI"
        LANG_MENU_1="Atur Mode (Family, Malware, Off)"
        LANG_MENU_2="Start Service (warp-svc)"
        LANG_MENU_3="Stop Service (warp-svc)"
        LANG_MENU_4="Connect WARP"
        LANG_MENU_5="Disconnect WARP"
        LANG_MENU_6="Status"
        LANG_MENU_7="Keluar"
        LANG_INFO_FAMILY="Family Mode Full diaktifkan.\nLayanan telah dibatasi untuk konten aman keluarga."
        LANG_INFO_MALWARE="Malware Mode diaktifkan.\nPerlindungan malware telah diaktifkan."
        LANG_INFO_OFF="Layanan telah dimatikan."
        LANG_INFO_SVC_START="Layanan warp-svc telah dimulai."
        LANG_ERROR_SVC_START="Gagal memulai layanan warp-svc."
        LANG_INFO_SVC_STOP="Layanan warp-svc telah dihentikan."
        LANG_ERROR_SVC_STOP="Gagal menghentikan layanan warp-svc."
        LANG_SUB_1="Family Mode Full"
        LANG_SUB_2="Malware Mode"
        LANG_SUB_3="Off"
        LANG_SUB_4="Kembali ke Menu Utama"
        LANG_INFO_CONNECT="Cloudflare WARP berhasil dihubungkan."
        LANG_INFO_DISCONNECT="Cloudflare WARP telah diputuskan."
        LANG_ERROR_INVALID="Pilihan tidak valid. Silakan coba lagi."
    fi

    # Ekspor semua variabel bahasa sehingga tersedia di seluruh skrip
    export LANG_TITLE LANG_MENU_1 LANG_MENU_2 LANG_MENU_3 LANG_MENU_4 LANG_MENU_5 LANG_MENU_6 LANG_MENU_7
    export LANG_INFO_FAMILY LANG_INFO_MALWARE LANG_INFO_OFF LANG_INFO_SVC_START LANG_ERROR_SVC_START LANG_INFO_SVC_STOP LANG_ERROR_SVC_STOP
    export LANG_SUB_1 LANG_SUB_2 LANG_SUB_3 LANG_SUB_4 LANG_INFO_CONNECT LANG_INFO_DISCONNECT LANG_ERROR_INVALID
}

# --- 3. EKSEKUSI AWAL: Pilih dan Muat Bahasa ---
# Panggil fungsi pemilihan bahasa dan muat teks
SELECTED_LANGUAGE=$(select_language)
load_language_texts "$SELECTED_LANGUAGE"


# --- FUNGSI WARP DAN LAYANAN (TIDAK BERUBAH) ---

family_mode() {
    zenity --info --text="$LANG_INFO_FAMILY"
    pkexec warp-cli set-mode family
    pkexec warp-cli connect
}

malware_mode() {
    zenity --info --text="$LANG_INFO_MALWARE"
    pkexec warp-cli set-mode malware
    pkexec warp-cli connect
}

turn_off() {
    zenity --info --text="$LANG_INFO_OFF"
    pkexec warp-cli disconnect
}

start_service() {
    pkexec systemctl start warp-svc
    if systemctl is-active --quiet warp-svc; then
        zenity --info --text="$LANG_INFO_SVC_START"
    else
        zenity --error --text="$LANG_ERROR_SVC_START"
    fi
}

stop_service() {
    pkexec systemctl stop warp-svc
    if ! systemctl is-active --quiet warp-svc; then
        zenity --info --text="$LANG_INFO_SVC_STOP"
    else
        zenity --error --text="$LANG_ERROR_SVC_STOP"
    fi
}

# --- SUBMENU MODE ---
submenu_mode() {
    while true; do
        MODE_OPTION=$(zenity --list --title="$LANG_TITLE - Mode" \
            --column="Mode" --width=300 --height=300 \
            "$LANG_SUB_1" \
            "$LANG_SUB_2" \
            "$LANG_SUB_3" \
            "$LANG_SUB_4")

        case $MODE_OPTION in
            "$LANG_SUB_1")
                family_mode
                ;;
            "$LANG_SUB_2")
                malware_mode
                ;;
            "$LANG_SUB_3")
                turn_off
                ;;
            "$LANG_SUB_4")
                break
                ;;
            *)
                zenity --error --text="$LANG_ERROR_INVALID"
                ;;
        esac
    done
}

# --- MENU UTAMA ---
while true; do
    OPTION=$(zenity --list --title="$LANG_TITLE" \
        --column="Menu Utama" --width=300 --height=400 \
        "$LANG_MENU_1" \
        "$LANG_MENU_2" \
        "$LANG_MENU_3" \
        "$LANG_MENU_4" \
        "$LANG_MENU_5" \
        "$LANG_MENU_6" \
        "$LANG_MENU_7")

    case $OPTION in
        "$LANG_MENU_1")
            submenu_mode
            ;;
        "$LANG_MENU_2")
            start_service
            ;;
        "$LANG_MENU_3")
            stop_service
            ;;
        "$LANG_MENU_4")
            pkexec warp-cli connect
            zenity --info --text="$LANG_INFO_CONNECT"
            ;;
        "$LANG_MENU_5")
            pkexec warp-cli disconnect
            zenity --info --text="$LANG_INFO_DISCONNECT"
            ;;
        "$LANG_MENU_6")
            # Tangkap output dari warp-cli status, termasuk error (2>&1)
            STATUS=$(warp-cli status 2>&1)

            # Hapus spasi kosong (whitespace) dari awal/akhir output untuk pemeriksaan yang bersih
            STATUS_TRIMMED=$(echo "$STATUS" | xargs)

            if [ -z "$STATUS_TRIMMED" ]; then
                # Jika status tetap kosong, tampilkan pesan error yang lebih informatif
                zenity --error --title="$LANG_TITLE - $LANG_MENU_6" \
                    --text="Gagal mendapatkan status WARP.\n\nBeberapa kemungkinan:
                    \n1. Layanan 'warp-svc' belum berjalan (coba 'Start Service').
                    \n2. Klien WARP belum terdaftar.
                    \n3. Ada masalah hak akses (walaupun pkexec seharusnya menangani ini)."
            else
                # Tampilkan status jika berhasil ditangkap
                zenity --info --title="$LANG_TITLE - $LANG_MENU_6" --text="$STATUS"
            fi
            ;;
        "$LANG_MENU_7")
            exit 0
            ;;
        *)
            zenity --error --text="$LANG_ERROR_INVALID"
            ;;
    esac
done
