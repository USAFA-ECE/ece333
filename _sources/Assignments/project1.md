# **Project 1: Characterizing Systems Using Impulse Responses in MATLAB**

## **1. Introduction & Background**

As you have learned in recent lessons, a central concept in signals and systems is the system **impulse response**. For any **linear time-invariant (LTI)** system, the impulse response fully characterizes the system's behavior. Once the impulse response is known, the system output to any input can be determined using **convolution**. This principle forms the foundation for much of electrical engineering analysis and design.

Impulse responses are not limited to abstract mathematical systems—they appear across many real world engineering applications:

*   **Communications systems**: In wireless and wired communications, the impulse response models the channel between a transmitter and receiver. Effects such as multipath propagation, delay spread, and fading are all captured in the channel impulse response. Equalization, matched filtering, and channel estimation techniques rely directly on impulse response models.
*   **Digital signal processing**: FIR and IIR filters are commonly described and designed through their impulse responses. Filter properties such as stability, causality, and frequency response are directly linked to the impulse response.
*   **Control systems**: The impulse response reveals transient behavior, settling time, and stability characteristics of dynamic systems, and is closely related to the system's transfer function and step response.
*   **Radar and sonar**: The impulse response of a target environment determines resolution and detection performance. Pulse compression and matched filtering rely on convolution with known impulse responses.
*   **Audio and acoustics**: Rooms and acoustic spaces can be approximated as LTI systems. A short, sharp sound approximates an impulse, and the resulting recording captures reverberation, reflections, and frequency coloration of the space.

In this project, you will explore impulse responses using **acoustic signals**. You will directly observe how an audio impulse response recorded in one room can shape an audio signal recorded in a different room by convolving the two in MATLAB. Although the medium is audio, the underlying concepts are identical to those used in communications channels, filters, and many other electrical engineering systems.

## **2. Project Objectives**

*   Explain why the impulse response completely characterizes an LTI system
*   Record real world signals using MATLAB
*   Visualize time domain signals and interpret their features
*   Apply convolution to model the effect of a system on an input signal
*   Relate acoustic impulse responses to impulse responses in communications and DSP systems

## **3. Pre Project Preparation**

Before starting Project 1, ensure that:

*   MATLAB is installed and has permission to access your microphone. To select the input device MATLAB uses, use the following commands:
    ```matlab
    % This saves the audio device information to a structure called 'info'
    info = audiodevinfo; 

    % This saves the input device information from the info structure to 
    % a new structure called 'target'; the 'x' should be replaced with 
    % the Field Number corresponding to the input device you wish to use. 
    % For example, you may wish to use your laptop's internal microphone 
    % which may correspond to Field Number 2 in the structure 'target'. 
    % Then you would replace x with 2.
    target = info.input(x); 
    ```
    Lines 6 and 7 of the provided MATLAB file called `RecordAudio.m` accomplish these same commands – you will need to ensure you have the correct Field Number in the parentheses on Line 7.

*   You have two recording environments available:
    *   A normal classroom or dorm room for speech recording
    *   A large, reverberant space (e.g., F1, Clune Arena) for the impulse response
*   Background noise is minimized as much as possible
*   You have downloaded the MATLAB files provided:
    *   Main project script, [AudioConvolution.m](files/AudioConvolution.m)
    *   Supporting function, [RecordAudio.m](files/RecordAudio.m)

## **4. Project Procedure**

### **Step 1: Record Normal Speech**

1.  Open `AudioConvolution.m`.
2.  When prompted, enter the desired recording time (5–10 seconds recommended).
3.  Speak something witty in a normal voice in a quiet room.
4.  MATLAB will play back the recording and display the waveform in the first subplot.

This signal represents the **input** to the system.

### **Step 2: Record an Acoustic Impulse Response**

1.  Move to a large room with noticeable reverberation, such as F1, a quiet hallway that echoes, or Clune Arena. Be creative!
2.  Generate a sound that approximates an impulse:
    *   Very short in time
    *   Loud relative to background noise
    *   Clean (minimal talking or movement nearby)
3.  Examples include:
    *   Slamming a book on a table or dropping it on the floor
    *   A sharp hand clap
    *   Again – be creative! You will find some sounds work better than others as impulse responses, so try to record more than one impulse response using different sounds.
4.  Record the sound using the provided function.
5.  MATLAB will plot the impulse response in the second subplot.

This signal represents the **system impulse response**, analogous to a channel impulse response in communications.

### **Step 3: Convolution**

1.  The script will convolve your speech signal with the impulse response: `convolvedOutput = conv(talking, impulseResponse);`
2.  The resulting signal will be plotted in the third subplot.
3.  Listen to the output audio.

The convolved signal should sound as if your speech occurred directly in the large room rather than the original recording environment. If that is not the case, then you may need to rerecord your impulse response!

### **Step 4: Outputs, Analysis, and Interpretation**

1.  Save the recordings of you talking normally, your best impulse response, and the convolved output as `.wav` files using MATLAB's `audiowrite` command. You will need to write your own code to do this. Look up `audiowrite` in MATLAB Help to know how to properly use it.
2.  As you review the plots and audio, consider:
    *   How does convolution change the duration and structure of the signal?
    *   What features of the impulse response appear in the output waveform?
    *   How is this process like signal distortion caused by a communications channel?
    *   Why does convolution correctly model the system's effect?

## **5. What to Submit**

Submit the following to Gradescope:

### **A. Audio Files**

Submit:
*   `talking.wav`
*   `impulseResponse.wav`
*   `convolvedOutput.wav`

(Use `audiowrite` in MATLAB.)

### **B. Project 1 report** in **PDF** format containing the following components:

#### **Required Figures**

Include:

1.  Normal speech waveform
2.  Recorded impulse response
3.  Convolved output signal

All figures must include:

*   Proper axis labels
*   Descriptive titles
*   Brief captions explaining key features

#### **Short Answer Questions**

Answer the following concisely:

1.  Why does the impulse response completely characterize an LTI system?
2.  How does the recorded room impulse response resemble a communications channel impulse response?
3.  What factors affected the quality of your impulse response recording?
4.  How would background noise or a long impulse affect the convolution result?

#### **Reflection (3–5 sentences)**

Briefly reflect on:

*   What this project revealed about convolution and impulse responses
*   How these concepts apply to your future coursework in robotics, communications, or DSP

## **6. Conclusion**

In Project 1 you demonstrated how an abstract mathematical concept—the impulse response—directly connects to physical systems encountered in electrical engineering. By recording real signals and performing convolution in MATLAB, you explored the same principles used to model filters, communications channels, and dynamic systems. Once a system's impulse response is known, its behavior for any input can be predicted.



