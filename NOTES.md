1.name of step
2. clip
3. time
4. style
5. Filter by style
6. Filter steps by clip and by style (not clips by style)



Step - name, level of mastery, notes, user_id
Video - url, title, year, notes, user_id
Style - name
User - username, password_digest


StepStyle - step_id, style_id
VideoStep - video_id, step_id



Video belongs to User
Step belongs to a User



Step has many video
video has many steps

User has many videos
User has many steps

Step has many styles
Style has many steps

Style has many videos through steps
video has many styles through steps


To fix/add:

Ability to add new style?










