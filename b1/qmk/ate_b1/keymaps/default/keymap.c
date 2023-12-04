#include QMK_KEYBOARD_H



enum custom_keycodes {
  RARROW = SAFE_RANGE,
  RPIPE
};

/*
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
	[0] = LAYOUT(
          KC_GRAVE, KC_1,       KC_2,       KC_3,       KC_4,       KC_5,       KC_6,       KC_7,       KC_8,       KC_9,       KC_0,       KC_MINS, 
          KC_TAB,   KC_Q,       KC_W,       KC_E,       KC_R,       KC_T,       KC_Y,       KC_U,       KC_I,       KC_O,       KC_P,       KC_BSPC, 
          KC_ESC,   KC_A,       KC_S,       KC_D,       KC_F,       KC_G,       KC_H,       KC_J,       KC_K,       KC_L,       KC_SCLN,    KC_ENT, 
          KC_LSFT,  KC_Z,       KC_X,       KC_C,       KC_V,       KC_B,       KC_N,       KC_M,       KC_COMM,    KC_DOT,     KC_SLSH,    KC_RSFT, 
          KC_LCTL,  KC_LGUI,    KC_LALT,    KC_ALGR,    MO(1),      KC_SPC,                 MO(2),      KC_LEFT,    KC_DOWN,    KC_UP,      KC_RGHT),
        [1] = LAYOUT(
          KC_TILD,  KC_EXLM,    KC_AT,      KC_HASH,    KC_DLR,     KC_PERC,    KC_CIRC,    KC_AMPR,    KC_ASTR,    KC_LPRN,    KC_RPRN,    KC_UNDS,
          _______,  LSFT(KC_Q), LSFT(KC_W), LSFT(KC_E), LSFT(KC_R), LSFT(KC_T), LSFT(KC_Y), LSFT(KC_U), LSFT(KC_I), LSFT(KC_O), LSFT(KC_P), KC_DEL,
          _______,  LSFT(KC_A), LSFT(KC_S), LSFT(KC_D), LSFT(KC_F), LSFT(KC_G), LSFT(KC_H), LSFT(KC_J), LSFT(KC_K), LSFT(KC_L), _______,    _______,
          _______,  LSFT(KC_Z), LSFT(KC_X), LSFT(KC_C), LSFT(KC_V), LSFT(KC_B), LSFT(KC_N), LSFT(KC_M), _______,    _______,    _______,    _______,
          _______,  _______,    _______,    _______,    _______,    KC_TAB,                 MO(3),      KC_HOME,    KC_PGDN,    KC_PGUP,    KC_END),
        [2] = LAYOUT(
          UC(0x2103), UC(0x00B0), UC(0x2261), _______, _______, _______, _______, _______, _______, _______, KCPLUS,  KC_PEQL,
          _______,  _______,    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
          _______,  UC(0x03B1), _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
          _______,  _______,    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
          _______,  _______,    _______, _______, MO(3),   _______,          _______, _______, _______, _______, _______),
        [3] = LAYOUT(
          _______,  _______,    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
          _______,  _______,    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
          QK_UNICODE_MODE_NEXT,  UC(0x2200), _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
          _______,  _______,    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
          _______,  _______,    _______, _______, _______, _______,          _______, _______, _______, _______, _______)
};
*/


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [0] = LAYOUT(
    KC_GRV    , KC_1      , KC_2      , KC_3      , KC_4      , KC_5      , KC_6      , KC_7      , KC_8      , KC_9      , KC_0      , KC_MINS   , 
    UC(0x2514), KC_Q      , KC_W      , KC_E      , KC_R      , KC_T      , KC_Y      , KC_U      , KC_I      , KC_O      , KC_P      , KC_BSPC   , 
    KC_ESC    , KC_A      , KC_S      , KC_D      , KC_F      , KC_G      , KC_H      , KC_J      , KC_K      , KC_L      , KC_SCLN   , KC_ENT    , 
    KC_LSFT   , KC_Z      , KC_X      , KC_C      , KC_V      , KC_B      , KC_N      , KC_M      , KC_COMM   , KC_DOT    , KC_SLSH   , KC_RSFT   , 
    KC_LCTL   , KC_LGUI   , KC_LALT   , KC_ALGR   , MO(1)     , KC_SPC                , MO(2)     , KC_LEFT   , KC_DOWN   , KC_UP     , KC_RIGHT  ),
  [1] = LAYOUT(
    KC_TILD   , KC_EXLM   , KC_AT     , S(KC_3)   , KC_DLR    , KC_PERC   , KC_CIRC   , KC_AMPR   , KC_ASTR   , KC_LPRN   , KC_RPRN   , KC_UNDS   , 
    UC(0x250c), S(KC_Q)   , S(KC_W)   , S(KC_E)   , S(KC_R)   , S(KC_T)   , S(KC_Y)   , S(KC_U)   , S(KC_I)   , S(KC_O)   , S(KC_P)   , KC_DEL    , 
    _______   , S(KC_A)   , S(KC_S)   , S(KC_D)   , S(KC_F)   , S(KC_G)   , S(KC_H)   , S(KC_J)   , S(KC_K)   , S(KC_L)   , KC_COLN   , _______   , 
    _______   , S(KC_Z)   , S(KC_X)   , S(KC_C)   , S(KC_V)   , S(KC_B)   , S(KC_N)   , S(KC_M)   , KC_LABK   , KC_RABK   , KC_QUES   , _______   , 
    _______   , _______   , _______   , _______   , _______   , KC_TAB                , MO(3)     , KC_HOME   , KC_PGDN   , KC_PGUP   , KC_END    ),
  [2] = LAYOUT(
    UC(0x2103), UC(0x00b0), UC(0x2261), UC(0x2248), UC(0x2265), UC(0x2264), UC(0x221d), UC(0x2260), UC(0x00d7), UC(0x22c5), KC_PLUS   , KC_EQL    , 
    UC(0x2518), UC(0x2502), UC(0x220b), UC(0x03b5), UC(0x03c1), UC(0x03b8), UC(0x21d2), UC(0x222a), UC(0x220f), KC_LCBR   , KC_RCBR   , KC_PIPE   , 
    _______   , UC(0x03b1), UC(0x03c3), UC(0x03b4), UC(0x2208), UC(0x22ef), RARROW    , RPIPE     , UC(0x22bc), KC_DQUO   , KC_QUOT   , _______   , 
    _______   , UC(0x2192), UC(0x03c7), UC(0x03b3), UC(0x2227), UC(0x03b2), UC(0x00ac), UC(0x03bc), KC_LBRC   , KC_RBRC   , KC_BSLS   , _______   , 
    _______   , _______   , _______   , _______   , MO(3)     , _______               , _______   , _______   , _______   , _______   , _______   ),
  [3] = LAYOUT(
    KC_F1     , KC_F2     , KC_F3     , KC_F4     , KC_F5     , KC_F6     , KC_F7     , KC_F8     , KC_F9     , KC_F10    , KC_F11    , KC_F12    , 
    UC(0x2510), UC(0x2500), UC(0x220c), UC(0x2203), UC(0x221a), UC(0x00b2), UC(0x21d0), UC(0x2229), UC(0x222b), UC(0x2205), UC(0x03c0),           , 
    _______   , UC(0x2200), UC(0x2211), UC(0x0394), UC(0x2209), UC(0x22ee), UC(0x221e), UC(0x22bb), UC(0x22bd), UC(0x03bb), UC(0x25cf), _______   , 
    _______   , UC(0x2190), UC(0x2194), UC(0x20ac), UC(0x2228), UC(0x00f7), UC(0x2207), UC(0x00b1), UC(0x2234), UC(0x2026), UC(0x220e), _______   , 
    _______   , _______   , _______   , _______   , _______   , _______               , _______   , _______   , _______   , _______   , _______ )
};

bool process_record_user(uint16_t keycode, keyrecord_t* record) {
  switch (keycode) {
    case RARROW:
      if (record->event.pressed) {
        SEND_STRING("<-");
      }
      return false;
    case RPIPE:
      if (record->event.pressed) {
        SEND_STRING("|>");
      }
      return false;
  }
  return true;
}

#if defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {

};
#endif // defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)





