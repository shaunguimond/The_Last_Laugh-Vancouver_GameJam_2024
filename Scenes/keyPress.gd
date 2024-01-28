extends Control

var labelNode: Label
var sentences: Array = ["In the once joyous city named Laugh Angeles, joy and laughter existed among all the residents.", 
"Comedians were making the town chuckle and laugh until tears came out of their eyes.", 
"That is until one day, when a mysterious force infiltrated the town, stealing everyones laughter away.", 
"Panic struck as the people of Laugh Angeles realized that their laughter had vanished. The town discovered the culprit was none other than the notorious comedian, Ratt Rofe. "]
var currentSentenceIndex: int = 0

func _ready():
	# Reference the Label node
	labelNode = $Label
	# Start displaying the initial sentence
	display_sentence()

func display_sentence():
	# Set the text of the Label to the current sentence
	labelNode.text = sentences[currentSentenceIndex]

func _process(delta):
	# Check for a key press (e.g., Space bar)
	if Input.is_action_just_pressed("ui_accept"):
		# Switch to the next sentence
		switch_sentences()

func switch_sentences():
	# Increment the sentence index for the next sentence
	currentSentenceIndex += 1

	# Check if there are more sentences
	if currentSentenceIndex < sentences.size():
		# Start displaying the next sentence
		display_sentence()
