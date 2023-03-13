# Dormie
Dormie is a Ruby on Rails application designed to facilitate the rental of dorms. It makes it simpler for landowners to rent out their dormitories; and it allows potential tenants to search and view the available rooms, communicate with the dorm owners, and secure the space of their choice.

![image](https://user-images.githubusercontent.com/81745755/222677205-f5826a5f-4d9f-4c47-aaa6-a53f331e25d1.png)

View the application here: **https://dormie.up.railway.app/**.

### Features
* Dorm owners and tenants registration.
* Search available dorms based on proximity and prices.
* Dorm owners can register their properties and list their rooms for rent.
* Tenants can search for available dorms and view details such as photos, pricing, and amenities.
* Interactive map.

-----
### Usage (development)
 1. clone the repository ``git clone https://github.com/jhwllsantiago/dormie.git``
 2. install dependencies ``bundle install``
 3. install libvips ``sudo apt install libvips``
 4. setup database ``rails db:setup`` (make sure the ``tags table`` was seeded)
 5. create a ``.env`` file and add the following
 
<pre>
 <b>GM_KEY</b>=yourgooglemapsapikey
 <b>USERNAME</b>=yourgmailusername
 <b>PASSWORD</b>=yourgmailpassword
</pre>