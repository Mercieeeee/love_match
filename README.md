# 💘 Love_Match: Decentralized Dating with a Touch of Cupid 💘

Welcome to **Love_Match**, the next-generation dating app that brings people together on the blockchain! Built on Stacks using Clarity, Love_Match leverages the magic of decentralized tech to help you find connections securely, with Cupid’s arrow leading the way.

---

## 💖 Features

- **💫 Profile Registration**: Set up a unique profile that’s forever yours on the blockchain.
- **📝 Profile Updates**: Update your profile as you grow, change, and explore!
- **🔎 Profile Lookup**: Retrieve any user’s profile by their blockchain address.
- **💌 Interest Discovery**: Peek into the interests of any registered user.

---

## 🔗 Contract Structure

Our love map, called `profiles`, stores a user’s unique identity, so no two profiles are the same. Every user has a secret address where their love profile resides, safe from prying eyes.

```clarity
(define-map profiles
  (address)
  { 
    name: (string-ascii 100),
    age: uint,
    interests: (list (string-ascii 50)),
    location: (string-ascii 100)
  }
)

## 💘💌💖 Functions to Find Your Match 💖💌💘

### `register-profile` 💕✨
Let Cupid register your profile with just the right details.
- **Parameters**:
  - `name` (string-ascii 100): 💁 Your name.
  - `age` (uint): 🎂 Your age.
  - `interests` (list of string-ascii 50): ❤️‍🔥 What makes you, *you*.
  - `location` (string-ascii 100): 📍 Where your heart resides.
- **Returns**: Success ✅ or heartbreak 💔 if profile already exists.

### `update-profile` 🔄💖
Give your profile a glow-up as you grow.
- **Parameters**:
  - `name` (string-ascii 100): ✍️ Updated name.
  - `age` (uint): 🎉 Updated age.
  - `interests` (list of string-ascii 50): 💃 New interests to share.
  - `location` (string-ascii 100): 🗺️ Your new love city.
- **Returns**: Cupid’s approval ✅ or error ❌ if profile is missing.

### `get-profile` 🕵️‍♀️💘
Retrieve the love profile of a chosen user.
- **Parameters**:
  - `user` (address): 🔑 Their unique address in the Love-Match world.
- **Returns**: A complete profile 💯 or a sad error 😞 if not found.

### `get-user-interests` ❤️✨
See what makes someone’s heart beat.
- **Parameters**:
  - `user` (address): 💌 Their unique address in the Love-Match world.
- **Returns**: Their interests 💖 or a sad error 😞 if not found.
