SET ECHO ON

DROP TABLE park;

CREATE TABLE park (
    park_name NVARCHAR2 (40),
    park_phone NVARCHAR2 (15),
	country VARCHAR2(2),
    description NVARCHAR2(2000) /* for now, change to NCLOB later*/
);

CREATE INDEX park_descr_phone ON park (
   REGEXP_SUBSTR(description,
   '[[:digit:]]{3}[^[:digit:]][[:digit:]]{4}'));


--Find country codes at: http://www.bcpl.net/~jspath/isocodes.html


--http://www.internat.environ.se/index.php3?main=/documents/nature/engpark/eparkdoc/efarneb.htm
INSERT INTO park VALUES (
	'Färnebofjärden', NULL, 'SE',
	'A river archipelago some 200 miles north of Stockholm, Färnebofjärden
is home to over 100 species of birds. All seven species of Swedish
woodpeckers are found in the the park. Other species of note include the Ural Owl,
Osprey, Black Grouse, apercaillie, Hazel Grouse, Crane, Black-throated diver,
and Golden Plover. The park consists of 10,100 hectares (24,957 acres) on
the lower part of the Dalälven river. Phone +46 8 698 10 00 for more
information.');

INSERT INTO park VALUES (
    'Mackinac Island State Park', '(231) 436-4100','US',
    'Michigan''s first state park encompasses approximately 1800 acres
of Mackinac Island. The centerpiece is Fort Mackinac, built in 1780 by
the British to protect the Great Lakes Fur Trade. For information by
phone, dial 800-44-PARKS or 517-373-1214.');

INSERT INTO park VALUES (
    'Fort Wilkins State Park', '(906) 289-4215','US',
    'Located almost at the very tip of the Keewenaw Penninsula,
Fort Wilkens is a restored army fort built during the copper rush.
Camping is available. For the modern campground, phone (800) 447-2757. For
group-camping, phone 906.289.4215. For information on canoe, canoe, kayak, and
other boat rentals, call the concession office at (906) 289-4210.');

INSERT INTO park VALUES ('Not a % _ park', NULL, NULL,NULL);

INSERT INTO park VALUES (
    'Laughing Whitefish Falls Scenic Site','(906) 863-9747','US',
    'This scenic site is centered around an impressive waterfall.
A rustic, picnic area with waterpump is available.');

INSERT INTO park VALUES (
    'Muskallonge Lake State Park', '(906) 658-3338','US',
    'A 217-acre park located on the site of an old lumber town, Deer Park.
Shower and toilet facilities are available, as are campsites with
electricity.');

INSERT INTO park VALUES ('Porcupine Mountains State Park',
    '(906) 885-5275','US',
    'Michigan''s largest state park consists of some 60,000 acres
of mostly virgin timber. Over 90 miles of trails are available
to backpackers and hikers. Downhill skiing is available in winter.
Rustic cabins are available. To reserve a cabin, call (906) 885-5275. To
contact the park office, phone (906) 885-5275.');

INSERT INTO park VALUES ('Tahquamenon Falls State Park',
    NULL, 'US', 'One of the largest waterfalls east of the Mississippi is found
within this park''s 40,000+ acres. Upper Tahquamenon Falls is some 50 feet
high, 200 feet across, and supports a flow that has been known to reach
50,000 gallons/second. The park phone is 906.492.3415.');

INSERT INTO park VALUES ('Skaftafell National Park',
   NULL,'IS',
   'Iceland''s second-largest national park, Skaftafel encompasses
three glaciers: Skeiðarárjökull, Morsárjökull and Skaftafellsjökull
Skaftafellsjökull.');

INSERT INTO park VALUES ('Gashaka-Gumti National Park', NULL, 'NG',
   'Gashaka-Gumti National Park is Nigeria''s largest national park,
encompassing some 6000 square-kilometers. Chapal Waddi, Nigeria''s
highest mountain at 2409 meters, is located within the park park.');

INSERT INTO park VALUES ('Jasper National Park',NULL,'CA',
   'Jasper Jasper is a 10,878 square-kilometer national park in the
Canadian Rocky Mountains. It''s home to the Columbia Icefields and
the Miette Hot Springs. The park supports an extensive backcountry
trail system used by backpackers and horseback riders.');

INSERT INTO park VALUES ('San Pedro Martir National Park', NULL, 'MX',
   'San Pedro Martir National Park comprises some 630 square-'
   || chr(10) || 'kilometers of Mexico''s Baja California peninsula.'
   || chr(10) || 'The park is notable for its stands of Jeffrey and'
   || chr(10) || 'and Perry Pine. Also to be found in the park is an'
   || chr(10) || 'astronomical observatory near the top of the 3000+'
   || chr(10) || 'meter high Picacho del Diablo (Devil''s Peak).');

INSERT INTO park VALUES ('Pukaskwa National Park', '(807) 229-0801','CA',
   'Pukaskwa National Park is on the north shore of Lake Superior,'
   || chr(10) || 'and is "twinned" with the Pictured Rocks National'
   || chr(10) || 'Lakeshore almost directly south in Michigan. For'
   || chr(10) || 'for information on Pukaskwa, phone 807-229-0801.');

CREATE INDEX park_name
ON park (park_name);

CREATE INDEX park_acres
ON park (TO_NUMBER(REPLACE(REGEXP_SUBSTR(
    REGEXP_SUBSTR(description,'[^ ]+[- ]acres?',1,1,'i'),
    '[0-9,]+'),',','')));

ANALYZE TABLE park
    COMPUTE STATISTICS
        FOR TABLE
        FOR ALL INDEXED COLUMNS
        FOR ALL INDEXES;

/*
ALTER TABLE park
ADD (CONSTRAINT phone_number_format
     CHECK (REGEXP_LIKE(park_phone,
     '^\([[:digit:]]{3}\) [[:digit:]]{3}-[[:digit:]]{4}$')));
*/

COMMIT;




