# Frontend Code -> Streamlit
import streamlit as st
from models import generate_prompt


# st.header('GEMINI LLM APPLICATION')
st.header('Gemini LLM')
st.subheader('Where to start?')

# st.text_input(
#     'First Name',
#     placeholder='Enter your First Name!!'
# )

user_input = st.text_area(
    'Prompt Input',
    placeholder = 'Enter your prompt here!!'
)

if st.button('Send Prompt🏹'):
    if user_input.strip() == '':
        st.warning('Enter valid prompt!!')
    else:
        with st.spinner('Thinking🤔...'):
            answer = generate_prompt(user_input)
            st.success('Content Generated!!')
            st.write(answer)