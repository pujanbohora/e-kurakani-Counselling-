from .serializers import *
from zoom_api_functions import *
import requests
from datetime import datetime as dt
from datetime import date, time
import json

def create_meeting(zoom_api_data, appointment_id):
    zoom_api_data['type'] = 2  # for scheduled meetings the type ID is 2
    if not zoom_api_data.get('timezone'):
        zoom_api_data['timezone'] = 'Asia/Kathmandu'
    server_start_time = zoom_api_data["server_start_time"]
    string_datetime = server_start_time.strftime("%Y-%m-%dT%H:%M:%S+5:45")
    zoom_api_data["server_start_time"] = string_datetime
    zoom_api_data["start_time"] = string_datetime
    headers = {'authorization': 'Bearer %s' % generateToken(),
                'content-type': 'application/json'}
    r = requests.post(
        f'https://api.zoom.us/v2/users/me/meetings',
        data=json.dumps(zoom_api_data),
        headers=headers)
    # return r.text
    # print(r.json())
    new_meeting = r.json()
    # print(new_meeting)
    # print(new_meeting['id'])
    processed_data = {
        'start_time': server_start_time,
        'zoom_meeting_id': new_meeting['id'],
        # 'created_by': zoom_api_data.pop('created_by'),
        # 'last_modified_by': zoom_api_data.pop('last_modified_by')
    }
    if appointment_id is not None:
        appointment_obj = Appointment.objects.get(id=appointment_id)
        processed_data['appointment'] = appointment_obj.id
    
    serializer = LiveMeetingSerializer(data=processed_data)
    serializer.is_valid(raise_exception=True)
    serializer.save()
    response_data = serializer.data 
    response_data["zoom_meeting"] = new_meeting
    return response_data


def update_meeting(am_object, zoom_api_data, appointment_id):
    processed_data = {
        'start_time': zoom_api_data['server_start_time'],
        # 'last_modified_by': zoom_api_data.pop('last_modified_by')
    }
    if appointment_id is not None:
        appointment_obj = Appointment.objects.get(id=appointment_id)
        processed_data["appointment"] = appointment_obj

    # print(processed_data)
    serializer = LiveMeetingSerializer(
        am_object, data=processed_data, partial=True)
    serializer.is_valid(raise_exception=True)
    serializer.save()
    response_data = serializer.data

    # Updating the Zoom Meeting
    headers = {'authorization': 'Bearer %s' % generateToken(),
                'content-type': 'application/json'}
    r = requests.patch(
        f'https://api.zoom.us/v2/meetings/{am_object.zoom_meeting_id}',
        data=json.dumps(zoom_api_data), headers=headers)
    # print(r)
    if r.status_code == 204:
        updated_meeting = requests.get(
            f'https://api.zoom.us/v2/meetings/{am_object.zoom_meeting_id}',
            headers=headers)
        # print(r.json())
        response_data['zoom_meeting'] = updated_meeting.json()
    
    return response_data


def list_meeting(qs, appointment_id):
    today_min = dt.combine(date.today(), time.min)
    queryset = qs.filter(
        start_time__gt=today_min)
    if appointment_id is not None:
        queryset = qs.filter(
            appointment__id=appointment_id, start_time__gt=today_min)
    
    # Getting the Zoom Meetings
    headers = {'authorization': 'Bearer %s' % generateToken(),
                'content-type': 'application/json'}
    r = requests.get(
        f'https://api.zoom.us/v2/users/me/meetings',
        headers=headers)
    # print(r.json())
    zoom_meetings = r.json()['meetings']
    # print(zoom_meetings)

    # Serializer
    serializer = LiveMeetingSerializer(queryset, many=True)
    response_data = serializer.data

    # print(response_data)
    # Preparing the zoom meetings for response
    for am in response_data:
        zoom_meeting_id = am['zoom_meeting_id']
        am_object = AppointmentMeeting.objects.get(id=int(am['id']))
        # print(am_object)
        am['api_url'] = am_object.get_api_url
        am['start_meeting_url'] = am_object.get_start_meeting_url
        # print(zoom_meeting_id)
        for m in zoom_meetings:
            # print(m['id'])
            if str(m['id']) == str(zoom_meeting_id):
                # print(m)
                am['zoom_meeting'] = m
                now = dt.now()
                meeting_start_time = m['start_time'].replace(
                    'T', ' ').replace('Z', '')
                meeting_start_time = dt.strptime(
                    meeting_start_time, "%Y-%m-%d %H:%M:%S")
                if meeting_start_time < now:
                    am['status'] = 'previous'
    
    return response_data


def retrieve_meeting(qs):

    serializer = LiveMeetingSerializer(qs, many=True)
    response_data = serializer.data
    headers = {'authorization': 'Bearer %s' % generateToken(),
                'content-type': 'application/json'}
    for am_obj in response_data:
    # Getting the Zoom Meeting
        r = requests.get(
            f'https://api.zoom.us/v2/meetings/{am_obj["zoom_meeting_id"]}',
            headers=headers)
        # print(r.json())
        am_obj['zoom_meeting'] = r.json()

    return response_data


def delete_meeting(am_object):
    headers = {'authorization': 'Bearer %s' % generateToken(),
                   'content-type': 'application/json'}
    r = requests.delete(
        f'https://api.zoom.us/v2/meetings/{am_object.zoom_meeting_id}?schedule_for_reminder=true&cancel_meeting_reminder=true',
        headers=headers)
    return r.status_code

